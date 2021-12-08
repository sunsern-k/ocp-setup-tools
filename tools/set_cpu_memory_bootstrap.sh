
# Accept input variables 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=2}
mem=${b:=8096}

govc vm.change -vm $RHCOS_WORKER -c 4 -m 16384

govc vm.change -vm $RHCOS_BOOTSTRAP -c $cpu -m $mem
govc vm.change -vm $RHCOS_INFRA_INT -c 4 -m 16384
govc vm.change -vm $RHCOS_INFRA_MON -c 8 -m 32768
govc vm.change -vm $RHCOS_ODF -c 16 -m 32768