
# Accept input variable 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=4}
mem=${b:=16384}

govc vm.change -vm $RHCOS_WORKER -c $cpu -m $mem