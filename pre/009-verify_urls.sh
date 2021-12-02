echo "Expecting 200"

for url in 'quay.io' 'console.redhat.com/openshift' 'github.com' "${vcenter}"
do
  echo "Status code: $(curl -s -o /dev/null -w "%{http_code}\n" https://${url}) - https://$url"
done

echo "Expecting 301"
for url in 'registry.connect.redhat.com' 'registry.redhat.io'
do
  echo "Status code: $(curl -s -o /dev/null -w "%{http_code}\n" https://${url}) - https://$url"
done
