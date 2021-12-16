# Infra - Loging/Monitoring - logmon
for node in log0
do
  for i in $(seq -s' ' $logmon_count)
  do
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra=
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/logmon=
  done
done