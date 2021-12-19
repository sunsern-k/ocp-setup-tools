is_vm=$1

if [ "$is_vm" = "vm" ] || [ "$is_vm" = "VM" ]
then
  for i in $(seq -s' ' $infra_mgt_count)
  do
    # DNS record
    vmfqdn="infra0"${i}.${OCP_DOMAIN}

    # VM name on vCenter
    # Ex: VMname is a DNS record
    # vmname_prefix="infra0"
    # vmname_suffix=".${OCP_DOMAIN}"
    # vmname="${vmname_prefix}${i}${vmname_suffix}"

    # EX: Customized VM name:  OCP_Int_Infrax_<IP_oct3>.<IP_oct4>
    vmname_prefix="OCP_Int_Infra0"
    vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
    vmname="${vmname_prefix}${i}_${vmname_suffix}"
 
    echo "Setting $vmname - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
    govc vm.change -vm $vmname -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"

  done
else
  echo "Setting $RHCOS_INFRA_MGT - guestinfo.ignition.config.data => the content of ${OCP_DIR}/worker.64"
  govc vm.change -vm $RHCOS_INFRA_MGT -e "guestinfo.ignition.config.data=$(cat ${OCP_DIR}/worker.64)"
fi
