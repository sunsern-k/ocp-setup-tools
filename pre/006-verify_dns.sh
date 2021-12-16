# Domain information
BASE_DOMAIN="$basedomain"
CLUSTER_NAME="$clustername"
OCP_DOMAIN="${CLUSTER_NAME}.${BASE_DOMAIN}"
# DNS Server
DNS_SERVER="$dnsserver"

# Command line - dig
A_RECORD="dig +noall +answer @${DNS_SERVER}"
PTR_RECORD="${A_RECORD} -x"

get_ip() { 
  ${A_RECORD} +short $1
}

# Verify the bootstrap
${A_RECORD} bootstrap.${OCP_DOMAIN}
${PTR_RECORD} $(get_ip  bootstrap.${OCP_DOMAIN})

# Verify the master nodes
node=master0
for i in $(seq -s' ' $master_count)
do
    ${A_RECORD} ${node}${i}.${OCP_DOMAIN}
    ${PTR_RECORD} $(get_ip ${node}${i}.${OCP_DOMAIN})
done

# Verify the worker nodes
node=worker0
for i in $(seq -s' ' $worker_count)
do
    ${A_RECORD} ${node}${i}.${OCP_DOMAIN}
    ${PTR_RECORD} $(get_ip ${node}${i}.${OCP_DOMAIN})
done

# Verify the infra nodes
node=infra0
for i in $(seq -s' ' $total_infra_count)
do
    ${A_RECORD} ${node}${i}.${OCP_DOMAIN}
    ${PTR_RECORD} $(get_ip ${node}${i}.${OCP_DOMAIN})
done

# Verify the logging-mon nodes
node=log0
for i in $(seq -s' ' $logmon_count)
do
    ${A_RECORD} ${node}${i}.${OCP_DOMAIN}
    ${PTR_RECORD} $(get_ip ${node}${i}.${OCP_DOMAIN})
done

# verify bastion
${A_RECORD} ${bastionhost}.${OCP_DOMAIN}

# Verify api / api-int
${A_RECORD} api.${OCP_DOMAIN}
${PTR_RECORD} $(get_ip api.${OCP_DOMAIN})

${A_RECORD} api-int.${OCP_DOMAIN}
${PTR_RECORD} $(get_ip api-int.${OCP_DOMAIN})

# Verify dummy.apps.<OCP_DOMAIN>
# It's not required PTR
${A_RECORD} openshift-console.apps.${OCP_DOMAIN}
