# Bootstrap
nip=$(dig +noall +answer @${dnsserver} +short bootstrap.${OCP_DOMAIN})
gw="$gateway"
nm="$netmask"
export IPCFG="ip=${nip}::${gw}:${nm}:bootstrap.${OCP_DOMAIN}:ens192:none nameserver=${dnsserver}"

# DNS record
vmfqdn="bootstrap.${OCP_DOMAIN}"

# Ex: VM name is a DNS record
# vmname="bootstrap.${OCP_DOMAIN}"

# EX: Customized VM name:  OCP_Int_Bootstrap_<IP_oct3>.<IP_oct4>
vmname_prefix="OCP_Int_Bootstrap"
vmname_suffix="$(dig +noall +answer @${dnsserver} +short $vmfqdn | cut -d. -f3,4)"
vmname="${vmname_prefix}_${vmname_suffix}"

# For DHCP
# export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}"

echo "Setting IP: $vmname -> $IPCFG"
echo govc vm.change -vm $vmname -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
govc vm.change -vm $vmname -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
