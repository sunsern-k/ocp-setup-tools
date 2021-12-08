vmname_prefix=""
vmname_subfix=""

for i in {1..3}
do
  vmname=${vmname_prefix}${i}${vmname_subfix}
  govc vm.clone -vm $RHCOS_MASTER -on=false $vmname
done
