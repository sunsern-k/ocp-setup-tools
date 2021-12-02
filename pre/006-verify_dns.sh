# Domain information
BASE_DOMAIN="$basedomain"
CLUSTER_NAME="$clustername"
OCP_DOMAIN="${CLUSTER_NAME}.${BASE_DOMAIN}"

# Worker nodes
WORKER_COUNT="$workercount"

# DNS Server
DNS_SERVER="$dnsserver"

# Command line - dig
CMDLINE="dig +noall +answer @${DNS_SERVER}"

# Verify the bootstrap
${CMDLINE} bootstrap.${OCP_DOMAIN}

# Verify the master nodes
# Update the node name as needed
for node in master0 log0 odf0
do 
  for i in {1..3}
  do
    ${CMDLINE} ${node}${i}.${OCP_DOMAIN}
  done
done

# Verify infra nodes 
# Update a number of infra nodes as needed
for node in infra0
do
  for i in {1..5}
  do
    ${CMDLINE} ${node}${i}.${OCP_DOMAIN}
  done
done


# Verify the worker node if there are more than 0
if [ ! "${WORKER_COUNT}" = "0" ]
then
  for node in worker0
  do
    for i in $(seq 1 ${WORKER_COUNT})
    do
      ${CMDLINE} ${node}${i}.${OCP_DOMAIN}
    done
  done
fi

# verify bastion
${CMDLINE} ${bastionhost}.${OCP_DOMAIN}

# Verify api / api-int
${CMDLINE} api.${OCP_DOMAIN}
${CMDLINE} api-int.${OCP_DOMAIN}

# Verify dummy.apps.<OCP_DOMAIN>
${CMDLINE} openshift-console.apps.${OCP_DOMAIN}
