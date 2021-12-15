cat <<END >${OCP_DIR}/ldap-sync.yaml
kind: LDAPSyncConfig
apiVersion: v1
url: $ldap_server 
bindDN: 'cn=xx,ou=xxx,dc=xxx,dc=xxx,dc=xxx' 
bindPassword: '<password>'
insecure: true
groupUIDNameMapping:
  "cn=xxx,ou=xxx,dc=xxx,dc=xxx,dc=xxx": GROUP1
augmentedActiveDirectory:
    groupsQuery:
        baseDN: "ou=groups,dc=xxx,dc=xxx"
        scope: sub
        derefAliases: never
        pageSize: 0
    groupUIDAttribute: dn 
    groupNameAttributes: [ cn ] 
    usersQuery:
        baseDN: "ou=users,dc=xxx,dc=xxx"
        scope: sub
        derefAliases: never
        filter: (objectclass=person)
        pageSize: 0
    userNameAttributes: [ mail ] 
    groupMembershipAttributes: [ memberOf ] 
END

echo "Creating a whitelist file. "
cat <<END > ${OCP_DIR}/whitelist.txt
CN=xxx,OU=XXX,DC=xxx,DC=xxx
CN=xxx,OU=XXX,DC=xxx,DC=xxx
END

echo "Creating a Secret for ldap-sync and whitelist..."
oc create secret generic ldap-sync --from-file=ldap-sync.yaml=${OCP_DIR}/ldap-sync.yaml --from-file=whitelist.txt=${OCP_DIR}/whitelist.txt


echo "Creating the LDAP Cronjob..."
cat <<END > ${OCP_DIR}/ldap-cronjob.yaml
apiVersion: batch/v1
kind: CronJob
  metadata:
    name: ldap-group-sync
spec:
  schedule: '00 0,12 * * *'
  suspend: false
  jobTemplate:
    spec:
      template:
        spec:
          serviceAccountName: ldap-sync
          restartPolicy: Never
          containers:
            - name: oc-cli
              command:
                - /bin/oc
                - adm
                - groups
                - sync
                - --whitelist=/ldap-sync/whitelist.txt
                - --sync-config=/ldap-sync/ldap-sync.yaml
                - --confirm
              image: registry.redhat.io/openshift4/ose-cli:latest
              imagePullPolicy: Always
              volumeMounts:
              - mountPath: /ldap-sync/
                name: config
                readOnly: true
          volumes:
          - name: config
            secret:
              defaultMode: 420
              secretName: ldap-sync
END
