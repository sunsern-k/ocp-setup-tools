vmname_prefix=""
vmname_suffix=""

vmname=${vmname_prefix}${vmname_suffix}

govc vm.clone -vm $RHCOS_BOOTSTRAP -on=false $vmname
