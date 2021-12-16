# Set taint only for ODF nodes
# ODF - https://access.redhat.com/documentation/en-us/red_hat_openshift_container_storage/4.8/html/managing_and_allocating_storage_resources/how-to-use-dedicated-worker-nodes-for-openshift-container-storage_rhocs

oc adm taint nodes -l node-role.kubernetes.io/storage node.ocs.openshift.io/storage="true":NoSchedule 