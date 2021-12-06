cat <<END >${OCP_DIR}/install-config.yaml
apiVersion: v1
baseDomain: $basedomain
proxy:
  httpProxy: $httpproxy
  httpsProxy: $httpsproxy
  noProxy: $noproxy 
compute:
- hyperthreading: Enabled   
  name: worker
  replicas: 0 
controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: 3 
metadata:
  name: $clustername 
networking:
  clusterNetwork:
    - cidr: $podcidr
      hostPrefix: $hostprefix
  machineNetwork:
    - cidr: $machinecidr
  networkType: OpenShiftSDN
  serviceNetwork:
    - $servicecidr
platform:
  vsphere:
    vcenter: $vcenter
    username: $vcenteruser 
    password: $vcenterpassword
    datacenter: $vcenterdatacenter 
    defaultDatastore: $vcenterdatastore 
    folder: "$vcenterfolder" 
fips: false 
pullSecret: $(echo "'$(echo $pullsecret)'")
sshKey: $(echo "'$(echo $ssh_public_key)'") 
END

if [ "$httpproxy" = "" ] || [ "$httpsproxy" = "" ]
then 
  echo "[Info]: Proxy configurations are not set..."
  echo "[Info]: Remove proxy configurations from the $INSTALL_CONFIG"
  sed -i '/proxy/d' $INSTALL_CONFIG
  sed -i '/Proxy/d' $INSTALL_CONFIG
fi
