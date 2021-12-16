
# Reference: https://access.redhat.com/solutions/5034771

echo "Creating patch to move the Ingrescontroller to dedicated infra nodes..."
echo "**PLEASE RUN THE FOLLOWING COMMAND**"
echo oc patch ingresscontroller/default -n  openshift-ingress-operator  --type=merge -p $(echo "'{\"spec\":{\"nodePlacement\": {\"nodeSelector\": {\"matchLabels\": {\"$ingress_node_selector\": \"\"}},\"tolerations\": [{\"effect\":\"NoSchedule\",\"key\": \"infra\",\"value\": \"reserved\"},{\"effect\":\"NoExecute\",\"key\": \"infra\",\"value\": \"reserved\"}]}}}'")