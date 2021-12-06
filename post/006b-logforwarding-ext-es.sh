
echo "Creating a secret - credentials of external ElasticSearch: ${es_url}..."
cat <<END >external-es-credentials.yaml
apiVersion: v1
kind: Secret
metadata:
  name: ext-es-credentials
data:
  username: $(echo $es_user | base64 -w0)
  password: $(echo $es_password | base64 -w0)
END

echo "Applying a secret - ext-es-credentials.."
oc apply -f external-es-credentials.yaml -n openshift-logging

cat <<END >external-es-config.yaml
kind: ClusterLogForwarder
metadata:
  name: instance
  namespace: openshift-logging
spec:
  outputs:
   - name: ext-es
     type: "elasticsearch"
     url: ${es_url}
     secret:
        name: ext-es-credentials
  pipelines:
   - name: all-to-default
    inputRefs:
    - infrastructure
    - application
    - audit
    outputRefs:
    - default
   - name: application-logs 
     inputRefs: 
     - application
     outputRefs:
     - ext-es
END