# Infra - ACM/Quay - infra-mgt
# Assuming the infra01 - infra03 are reserved for ACM/Quay
for node in infra0
do
  for i in $(seq -s' ' $infra_mgt_count)
  do
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra=
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra-mgt=
  done
done