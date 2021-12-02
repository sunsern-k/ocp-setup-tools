if ! "$mtu" = "" ]
then
cat <<END > ${OCP_DIR}/manifests/cluster-network-03.config.yaml
apiVersion: operator.openshift.io/v1
kind: Network
metadata:
  name: cluster
spec:
  defaultNetwork:
    openshiftSDNConfig:
      mtu: $mtu
END
chmod 640 ${OCP_DIR}/manifests/cluster-network-03.config.yaml
fi
