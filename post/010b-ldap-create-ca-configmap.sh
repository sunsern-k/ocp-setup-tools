
caf=$1

if [ ! "$caf" = "" ]
then
  ca_file=$caf
fi

if [ "$ca_file" = "" ] || [ ! -f $ca_file ]
then
  echo "Please verify the absolute path to the ca file or set the ca_file variable."
else
  echo "Creaing a Configmap: ca-config-map containing a ca of LDAP server in the openshift-config "
  oc create configmap ca-config-map --from-file=ca.crt=$ca_file -n openshift-config
fi
