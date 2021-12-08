vmname_prefix=""
vmname_suffix=""

for i in {1..2}
do
  vmname=${vmname_prefix}${i}${vmname_suffix}
  govc vm.clone -vm $RHCOS_INFRA_INT -on=false $vmname
done