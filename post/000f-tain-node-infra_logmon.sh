oc adm taint nodes -l node-role.kubernetes.io/infra-mgt infra=reserved:NoSchedule infra=reserved:NoExecute
oc adm taint nodes -l node-role.kubernetes.io/infra-int infra=reserved:NoSchedule infra=reserved:NoExecute
oc adm taint nodes -l node-role.kubernetes.io/logmon infra=reserved:NoSchedule infra=reserved:NoExecute