echo "Waiting for the installation to complete..."
echo "openshift-install --dir=${OCP_DIR} wait-for install-complete --log-level=info"
openshift-install --dir=${OCP_DIR} wait-for install-complete --log-level=info
