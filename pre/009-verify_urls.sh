echo "Expecting 200"
curl -s -o /dev/null -w "%{http_code}\n" https://quay.io
curl -s -o /dev/null -w "%{http_code}\n" https://console.redhat.com/openshift 
curl -s -o /dev/null -w "%{http_code}\n" https://github.com

VCENTER="https://$vcenter"
curl -s -o /dev/null -w "%{http_code}\n" ${VCENTER}

echo "Expecting 301"
curl -s -o /dev/null -w "%{http_code}\n" https://registry.connect.redhat.com
curl -s -o /dev/null -w "%{http_code}\n" https://registry.redhat.io
