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
        - sAMAccountName
      bindDN: "cn=ocbsys,ou=xxxx,dc=sddc,dc=poc,dc=local" 
      bindPassword: 
        name: ldap-secret
      ca: 
        name: ca-config-map
      insecure: true 
      url: "ldaps://192.168.129.132:636/dc=sddc,dc=poc,dc=local?uid" 
END

echo "Applying LDAP configurations: ${OCP_DIR}/ldap-idp.yaml..."
oc apply -f ${OCP_DIR}/ldap-idp.yaml