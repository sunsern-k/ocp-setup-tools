
# monitoring_node_selector='node-role.kubernetes.io/<role>: ""'
# This should be set from post_env
# Toletation: infra=reserved:NoSchedule infra=reserved:NoExecute

cat <<END > "${monitoring_config}"
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
        ${monitoring_node_selector}
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
        ${monitoring_node_selector}
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
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    kubeStateMetrics:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    grafana:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    telemeterClient:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    k8sPrometheusAdapter:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    openshiftStateMetrics:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    thanosQuerier:
      nodeSelector:
        ${monitoring_node_selector}
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
END
