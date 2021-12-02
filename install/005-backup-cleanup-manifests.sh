echo "Backuping up: ${OCP_DIR}/openshift/99_openshift-cluster-api_worker-machineset-0.yaml to ${OCP_BACKUP}"
mv ${OCP_DIR}/openshift/99_openshift-cluster-api_worker-machineset-0.yaml ${OCP_BACKUP}
echo "Removing: ${OCP_DIR}/openshift/99_openshift-cluster-api_master-machines-*"
rm -rf ${OCP_DIR}/openshift/99_openshift-cluster-api_master-machines-*
