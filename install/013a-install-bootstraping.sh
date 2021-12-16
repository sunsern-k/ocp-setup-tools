echo "Monitoring the bootstrap to complete..."
echo "openshift-install --dir=${OCP_DIR} wait-for bootstrap-complete --log-level=debug"
openshift-install --dir=${OCP_DIR} wait-for bootstrap-complete --log-level=debug
