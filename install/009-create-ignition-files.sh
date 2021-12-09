echo "Creating ignition configs..."
echo "openshift-install create ignition-configs --dir=${OCP_DIR}"
openshift-install create ignition-configs --dir=${OCP_DIR}
