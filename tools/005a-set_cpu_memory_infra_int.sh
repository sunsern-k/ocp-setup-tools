
# Accept input variables 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=4}
mem=${b:=8096}

echo "govc vm.change -vm $RHCOS_INFRA_INT -c $cpu -m $mem"
govc vm.change -vm $RHCOS_INFRA_INT -c $cpu -m $mem

echo "**IMPORTANT NOTE: Disk is not configured by this script. Access vCenter UI to re-configure disk size**"

