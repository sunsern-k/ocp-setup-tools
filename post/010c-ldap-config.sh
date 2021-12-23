echo "Generating LADP configurations: ${OCP_DIR}/ldap-idp.yaml..."

cat <<END > ${OCP_DIR}/ldap-idp.yaml
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
  - name: ldapidp 
    mappingMethod: claim 
    type: LDAP
    ldap:
      attributes:
        id: 
        - dn
        email: 
        - mail
        name: 
        - givenName
        preferredUsername: 
        - cn
      bindDN: "$binddn" 
      bindPassword: 
        name: ldap-secret
      insecure: true 
      url: "$ldap_server/$ldap_query_string" 
END

echo "Applying LDAP configurations: ${OCP_DIR}/ldap-idp.yaml..."
oc apply -f ${OCP_DIR}/ldap-idp.yaml
