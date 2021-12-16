
## Move image-registry pods to dedicated nodes
# **Patch `configs.imageregistry.operator.openshift.io/cluster` with the infra-specific node**
# ***Adjust the node lables as appropriate*** 
# NOTE: 
# **It could be patched only `replica`; for example, from 2 to 3 if required 3 replica .**  
# oc patch ingresscontroller/default -n openshift-ingress-operator --type=merge -p '{"spec":{"replicas": 3}}'
# Reference:  https://access.redhat.com/solutions/5034771


echo "Setting the node selector and tolerations on the image registry .."
echo "'{\"spec\":{\"nodeSelector\": {\"${registry_node_selector}\"},\"tolerations\": [{\"effect\":\"NoSchedule\",\"key\": \"infra\",\"value\": \"reserved\"},{\"effect\":\"NoExecute\",\"key\": \"infra\",\"value\": \"reserved\"}]}}'"
oc patch configs.imageregistry.operator.openshift.io/cluster --type=merge -p $(echo "'{\"spec\":{\"nodeSelector\": {\"${registry_node_selector}\"},\"tolerations\": [{\"effect\":\"NoSchedule\",\"key\": \"infra\",\"value\": \"reserved\"},{\"effect\":\"NoExecute\",\"key\": \"infra\",\"value\": \"reserved\"}]}}'")