echo "Creating the logForwarding all to default (OpenShift ElasticSearch).."
cat <<END > ${OCP_DIR}/logforwarding-all-to-default.yaml
apiVersion: logging.openshift.io/v1
kind: ClusterLogForwarder
metadata:
  name: instance
  namespace: openshift-logging
spec:
  pipelines: 
  - name: all-to-default
    inputRefs:
    - infrastructure
    - application
    - audit
    outputRefs:
    - default
END
echo "The following configurations are applying..."
echo "$(cat ${OCP_DIR}/logforwarding-all-to-default.yaml)"
oc apply -f ${OCP_DIR}/logforwarding-all-to-default.yaml