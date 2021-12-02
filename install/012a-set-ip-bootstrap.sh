# Bootstrap
nip=$(dig +noall +answer @${dnsserver} +short bootstrap.${OCP_DOMAIN})
gw="$gateway"
nm="$netmask"
export IPCFG="ip=${nip}::${gw}:${nm}:bootstrap.${OCP_DOMAIN}:ens192:none nameserver=${dnsserver}"

# For DHCP
# export IPCFG="ip=ens192:dhcp nameserver=${dnsserver}"

echo $IPCFG
govc vm.change -vm "bootstrap.${OCP_DOMAIN}" -e "guestinfo.afterburn.initrd.network-kargs=${IPCFG}"
