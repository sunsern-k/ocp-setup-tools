for i in $(seq -s' ' $master_count)
do
  # DNS record
  vmfqdn="master0"${i}.${OCP_DOMAIN}

  # VM name on vCenter 
  # Ex: VMname is a DNS record
  # vmname_prefix="master0"
  # vmname_suffix=".${OCP_DOMAIN}"
  # vmname="${vmname_prefix}${i}${vmname_suffix}"
  
  # EX: Customized VM name:  OCP_Int_Masterx_<IP_oct3>.<IP_oct4>
  vmname_prefix="OCP_Int_Master0"
  vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
  vmname="${vmname_prefix}${i}_${vmname_suffix}"

  govc vm.clone -vm $RHCOS_MASTER -on=false $vmname
done
