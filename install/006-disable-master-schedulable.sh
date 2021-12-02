echo "**Before**"; grep mastersSchedulable ${OCP_DIR}/manifests/cluster-scheduler-02-config.yml
sed -i 's/mastersSchedulable: true/mastersSchedulable: false/g' ${OCP_DIR}/manifests/cluster-scheduler-02-config.yml
echo "**After**"; grep mastersSchedulable ${OCP_DIR}/manifests/cluster-scheduler-02-config.yml
