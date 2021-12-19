ssh -i $ssh_public_key_file core@bootstrap.${OCP_DOMAIN} bash -c "sudo crictl pods"
for i in $(seq -s' ' $master_count)
do 
  ssh -i $ssh_public_key_file core@master0$i.${OCP_DOMAIN} bash -c "sudo crictl pods"
done
