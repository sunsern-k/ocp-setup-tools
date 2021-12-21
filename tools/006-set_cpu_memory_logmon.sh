
# Accept input variables 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=8}
mem=${b:=32768}

echo "govc vm.change -vm $RHCOS_LOGMON -c $cpu -m $mem"
govc vm.change -vm $RHCOS_LOGMON -c $cpu -m $mem

echo "**IMPORTANT NOTE: Disk is not configured by this script. Access vCenter UI to re-configure disk size**"

