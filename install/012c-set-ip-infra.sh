
for i in {1..2}
do
  # DNS record
  vmfqdn="infra0${i}.${OCP_DOMAIN}"

  # VM name on vCenter 
  # Ex: VMname is a DNS record
  # vmname_prefix="infra0"
  # vmname_suffix=".${OCP_DOMAIN}"
  # vmname="${vmname_prefix}${i}${vmname_suffix}"
  
  # EX: Customized VM name:  OCP_Int_Infrax_<IP_oct3>.<IP_oct4>
  vmname_prefix="OCP_Int_Infra"
  vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
  vmname="${vmname_prefix}${i}_${vmname_suffix}"
  
  # Searching for an IP address from DNS
  nip=$(dig +noall +answer @${dnsserver} +short $vmfqdn)
  gw="$gateway"
  nm="$netmask"
  export IPCFG="ip=${nip}::${gw}:${nm}:${vmfqdn}:ens192:none nameserver=${dnsserver}"

  # For DHCP
  # export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}"

  echo "Setting IP: $vmname -> $IPCFG"
  govc vm.change -vm "$vmname" -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
done 