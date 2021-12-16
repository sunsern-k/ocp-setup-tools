
# Accept input variables 1: cpu 2: memory
c=$1
m=$2

# If it's not set then go for default values. 
cpu=${c:=2}
mem=${b:=8096}

govc vm.change -vm $RHCOS_BOOTSTRAP -c $cpu -m $mem

# disk cannot be configured from govc command...
# So it might be better to update CPU/Memory/Disk all from UI. 