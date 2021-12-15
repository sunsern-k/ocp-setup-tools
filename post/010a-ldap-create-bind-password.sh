bpw=$1
if [ ! "$bpw" = "" ]
then
  bind_password=$bpw
fi

if [ "$bind_password" = "" ]
then
  echo "Please specifcy a bind password or set the bind_password variable."
else
  echo "Creaing a Secret: ldap-secret containing a bind password in the openshift-config "
  oc create secret generic ldap-secret --from-literal=bindPassword=$bind_password -n openshift-config
fi