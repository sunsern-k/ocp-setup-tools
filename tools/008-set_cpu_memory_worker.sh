
# Accept input variable 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=4}
mem=${b:=16384}

echo "govc vm.change -vm $RHCOS_WORKER -c $cpu -m $mem"
govc vm.change -vm $RHCOS_WORKER -c $cpu -m $mem


echo "**IMPORTANT NOTE: Disk is not configured by this script. Access vCenter UI to re-configure disk size**"

