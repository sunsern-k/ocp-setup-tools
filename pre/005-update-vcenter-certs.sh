mkdir vcenter_certs; cd vcenter_certs
export VCENTER_URL=https://"$vcenter"
export VCENTER_CERTS_URL=${VCENTER_URL}/certs/download.zip

wget --no-check-certificate $VCENTER_CERTS_URL

unzip download.zip

sudo cp certs/lin/* /etc/pki/ca-trust/source/anchors
sudo update-ca-trust extract

