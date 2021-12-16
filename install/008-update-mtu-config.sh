if [ ! "$sdn_mtu" = "" ]
then
  echo "Updating the SDN mtu: $sdn_mtu -  ${OCP_DIR}/manifests/cluster-network-03.config.yaml"

cat <<END > ${OCP_DIR}/manifests/cluster-network-03.config.yaml
apiVersion: operator.openshift.io/v1
kind: Network
metadata:
  name: cluster
spec:
  defaultNetwork:
    openshiftSDNConfig:
      mtu: $sdn_mtu
END

  chmod 640 ${OCP_DIR}/manifests/cluster-network-03.config.yaml
  ls ${OCP_DIR}/manifests/cluster-network-03.config.yaml
  cat ${OCP_DIR}/manifests/cluster-network-03.config.yaml

else
 echo "Skipped - the SDN mtu is not specified - assumed 1450 which is the default value"
fi
