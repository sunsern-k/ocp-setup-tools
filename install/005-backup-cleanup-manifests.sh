echo "Backuping up: ${OCP_DIR}/openshift/99_openshift-cluster-api_worker-machineset-*.yaml to ${OCP_BACKUP}"
mv ${OCP_DIR}/openshift/99_openshift-cluster-api_worker-machineset-*.yaml ${OCP_BACKUP}
echo "Removing: ${OCP_DIR}/openshift/99_openshift-cluster-api_master-machines-*.yaml"
rm -rf ${OCP_DIR}/openshift/99_openshift-cluster-api_master-machines-*.yaml
