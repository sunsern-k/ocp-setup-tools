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
    folder: "/$vcenterdatacenter/vm/$clustername" 
fips: false 
pullSecret: $(echo "'$(echo $pullsecret)'")
sshKey: $(echo "'$(echo $ssh_public_key)'") 
END
