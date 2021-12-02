
# logmon_node_selector='node-role.kubernetes.io/<role>: ""'
# This should be set from post_env
# Toletation: infra=reserved:NoSchedule infra=reserved:NoExecute

cat <<END > "${cluster_monitoring_config}"
apiVersion: v1
kind: ConfigMap
metadata:
  name: cluster-monitoring-config
  namespace: openshift-monitoring
data:
  config.yaml: |
    enableUserWorkload: true
    prometheusOperator:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    prometheusK8s:
      retention: ${prometheusk8s_retention}
      volumeClaimTemplate:
        metadata:
          name: prometheus
        spec:
          storageClassName: ${prometheusk8s_stroageclass}
          resources:
            requests:
              storage: ${prometheusk8s_storage_size}
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    alertmanagerMain:
      volumeClaimTemplate:
        metadata:
          name: alertmanager 
        spec:
          storageClassName: ${alertmanager_storageclass}
          resources:
            requests:
              storage: ${alertmanager_storage_size}
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    kubeStateMetrics:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    grafana:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    telemeterClient:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    k8sPrometheusAdapter:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    openshiftStateMetrics:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    thanosQuerier:
      nodeSelector:
        ${logmon_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
END
