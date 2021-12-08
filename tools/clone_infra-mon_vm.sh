vmname_prefix=""
vmname_suffix=""

for i in {1..3}
do
  vmname=${vmname_prefix}${i}${vmname_suffix}
  govc vm.clone -vm $RHCOS_INFRA_MON -on=false $vmname
done