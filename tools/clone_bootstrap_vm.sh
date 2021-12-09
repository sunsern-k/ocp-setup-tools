# DNS record
vmfqdn="bootstrap.${OCP_DOMAIN}"

# Ex: VM name is a DNS record
# vmname="bootstrap.${OCP_DOMAIN}"

# EX: Customized VM name:  OCP_Int_Bootstrap_<IP_oct3>.<IP_oct4>
vmname_prefix="OCP_Int_Bootstrap"
vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
vmname="${vmname_prefix}_${vmname_suffix}"

govc vm.clone -vm $RHCOS_BOOTSTRAP -on=false $vmname
