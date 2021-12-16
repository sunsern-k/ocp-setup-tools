# ODF - storage
for node in odf0
do
  for i in $(seq -s' ' $odf_count)
  do
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra=
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/storage=
    oc label node ${node}${i}.${OCP_DOMAIN} cluster.ocs.openshift.io/openshift-storage=
  done
done