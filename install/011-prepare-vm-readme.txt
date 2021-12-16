11) - Download RHEL COROS and import to vCenter 

  - 11.1 - Download from https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.9/latest/rhcos-4.9.0-x86_64-vmware.x86_64.ova


  - 11.2 - Create a folder in the datacenter following `$clustername`  
      - Login VCenter -> Data Center -> `VMs and Templates` view
      - Right-click the name of the datacenter 
      - Click `New Folder` -> `New VM and Template Folder` and name `$clustername` 
      - Alternatively, use `govc folder.create /$vcenterdatacenter/vm/${clustername}`

  - 11.3 - Import the RHEL CoreOS ova file as a VM template 
      - From the Hosts and Clusters tab, right-click your cluster name and select `Deploy OVF Template`.
      - On the `Select an OVF` tab, specify the name of the RHCOS OVA file that you downloaded.
      - On the `Select a name and folder` tab, set a `Virtual machine name` **Template-rhcos** for your template, such as Template-rhcos. Click the name of your vSphere cluster and select the folder you created in the previous step.
      - On the `Select a compute resource` tab, click the name of your vSphere cluster.
         - CPU `4`
         - Memory `16GB`
         - Disk: `xxxGB` - based on requirements (at least 100GB) 
         - NOTE: Make it ready for `bootstrap` and `master`
      - On the `Select storage` tab, configure the storage options for your VM.
      - Select `Thin Provision` or `Thick Provision`, based on your storage preferences.
      - Select the datastore that you specified in your `install-config.yaml` file.
      - On the `Select network` tab, specify the network that you configured for the cluster, if available.
      - When creating the OVF template, **do not specify values on the Customize template tab** or configure the template any further.

      NOTE: It's advisable to copy this template from `Template-rhos` to `Template-rhcos-untouched` to have the untouched template. 

# The rhcos comes with VMWare Hardware version 13, so it is required to upgrade to the latest
# Otherwise it will show a Warning below after the cluster installation and it won't be convenient  
# to shutdown each VM and upgrade the hardware version.
#
# The cluster is using VMs with hardware version lower than 15, which is being deprecated by 
# Openshift. Hardware version 15 or greater is required by vSphere CSI driver. Please update your 
# VMs t o at least HW version 15.

# Covert a template to be a vm and it can be upgraded by:
# govc vm.upgrade -vm /$vcenterdatacenter/vm/$clustername/<template-vm-name>

# Then clone each VMs and ensure CPU/Memory/Network/Disk/

# Some useful govc commands:
#
# Clone a VM from another VM 
# govc vm.clone -vm /$vcenterdatacenter/vm/$clustername/Template-rhcos -on=false Template-rhcos-untouched

# Make a VM to be a template
# govc vm.markastemplate Template-rhcos-untouched

# Make a template to be a VM
# govc vm.markasvm -host $vcenterhost Template-rhcos-bootstrap

# Add parameters: 
# govc vm.change -vm "Template-rhcos" -e "disk.EnableUUID=TRUE" -e "guestinfo.ignition.config.data.encoding=base64"
# govc vm.change -vm "Template-rhcos" -latency=high

# Adjust CPU/Memory: 
# govc vm.change -vm Template-rhcos-worker -c 2 -m 8192 
# govc vm.change -vm Template-rhcos-master -c 4 -m 16384
# govc vm.change -vm Template-rhcos-bootstrap -c 2 -m 8096
# govc vm.change -vm Template-rhcos-infra -c 4 -m 8096
# 
# Add base64-encoded igition data
# Bootstrap
# govc vm.change -vm Template-rhcos-bootstrap -e "guestinfo.ignition.config.data=$(cat ${HOME}/append-bootstrap.64)"
#
# Master
# govc vm.change -vm Template-rhcos-master -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/master.64)"
#
# Worker 
# govc vm.change -vm Template-rhcos-worker -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
#
# IP addresse - static 
# bootstrap
# export IPCFG="ip=${node_ip}::${gw}:${netmask}:bootstrap.${OCP_DOMAIN}:ens192:none nameserver=${dnsserver}"
# govc vm.change -vm "bootstrap.${OCP_DOMAIN}" -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"


