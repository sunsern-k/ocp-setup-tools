# Reference: https://access.redhat.com/solutions/6578421


echo "Switching to openshift-logging project.."
oc project openshift-logging

#oc patch deployment/<elasticsearch_deployment_name> --type=merge -p '{"spec":{"paused": false}}'
#oc set env deployment/<elasticsearch_deployment_name> -c elasticsearch ES_JAVA_OPTS="-Dlog4j2.formatMsgNoLookups=true"

echo "Verifying the ES_JAVA_OPTS being configured..."
echo oc set env -c elasticsearch rs -l component=elasticsearch --list | grep ES_JAVA_OPTS
oc set env -c elasticsearch rs -l component=elasticsearch --list | grep ES_JAVA_OPTS


echo "Then, please update Unmanaged by following commands"

echo oc edit clusterlogging/instance
echo '[...]'
echo 'spec:'
echo '[...]'
echo '  managementState: Unmanaged'
echo '[...]'
echo oc edit elasticsearch/elasticsearch
echo '[...]'
echo 'spec:'
echo '[...]'
echo '  managementState: Unmanaged'
echo '[...]'

echo "Then Run: oc get clusterlogging; oc get elasticsearch"  
