echo "Monitoring the bootstrap to complete..."
echo "openshift-install --dir=${OCP_DIR} wait-for bootstrap-complete --log-level=info"
openshift-install --dir=${OCP_DIR} wait-for bootstrap-complete --log-level=info
