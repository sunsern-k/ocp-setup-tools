
[ "$start_infra_int" = "" ] && start_infra_int=1

# Consider infra_int may not running from infra01, infra02, and so on. 
# If it is started from infra04 and the infra_int_count is 2 then they are infra04 and infra05
# Then run seq -s' '  <start> <end> ; where <end> is <start> + <infra_int_count> - 1

for node in infra0
do
  for i in $(seq -s' ' $start_infra_int $(($infra_int_count + $start_infra_int -1)) )
  do
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra=
    oc label node ${node}${i}.${OCP_DOMAIN} node-role.kubernetes.io/infra-int=
  done
done