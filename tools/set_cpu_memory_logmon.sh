
# Accept input variables 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=8}
mem=${b:=32768}

govc vm.change -vm $RHCOS_LOGMON -c $cpu -m $mem
