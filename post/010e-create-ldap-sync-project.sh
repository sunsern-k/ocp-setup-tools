is_created=$(oc projects -q |grep "^ldap-sync")
ldap_project="ldap-sync"

if [ "$is_created" = "" ]
then
  echo "Creating ldap-sync project..."
  echo "oc new-project $ldap_project"
  oc new-project $ldap_project
else
  oc project $ldap_project
fi

echo "Creating a service account: ldap-sync..."
echo "oc create sa ldap-sync"
oc create sa ldap-sync

echo "Creating a clusterole: ldap-group-sync..."
echo "oc create clusterrole ldap-group-sync --verb=create,update,patch,delete,get,list --resource=groups.user.openshift.io"
oc create clusterrole ldap-group-sync --verb=create,update,patch,delete,get,list --resource=groups.user.openshift.io

echo "Creating a cluster role binding..."
echo "oc adm policy add-cluster-role-to-user ldap-group-sync -z ldap-sync -n ldap-sync"
oc adm policy add-cluster-role-to-user ldap-group-sync -z ldap-sync -n ldap-sync
