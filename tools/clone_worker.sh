vmname_prefix=""
vmname_subfix=""

for i in {1..2}
do
  vmname=${vmname_prefix}${i}${vmname_subfix}
  govc vm.clone -vm $RHCOS_WORKER -on=false $vmname
done
