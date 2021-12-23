echo "Applying the project-request template to openshift-config"

oc create -f project-request.yaml -n openshift-config
echo "#########"
echo "Running the oc edit project.config.openshift.io/cluster"
echo "Then add"
echo "spec:"
echo "  projectRequestTemplate:"
echo "    name: project-request"