vmname_prefix=""
vmname_subfix=""

vmname=${vmname_prefix}${i}${vmname_subfix}

govc vm.clone -vm $RHCOS_BOOTSTRAP -on=false $vmname
