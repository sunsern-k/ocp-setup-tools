echo "Backuping up the network config file: ${OCP_DIR}/manifests/cluster-network-03.config.yaml"
cp ${OCP_DIR}/manifests/cluster-network-03.config.yaml ${OCP_BACKUP}
yq e -i '.defaultNetwork.openshiftSDNConfig.mtu = $mtu' ${OCP_DIR}/manifests/cluster-network-03.config.yaml
grep -B 3 'mtu' ${OCP_DIR}/manifests/cluster-network-03.config.yaml
