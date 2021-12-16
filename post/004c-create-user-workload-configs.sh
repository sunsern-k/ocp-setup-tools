
# monitoring_node_selector='node-role.kubernetes.io/<role>: ""'
# This should be set from post_env
# Toletation: infra=reserved:NoSchedule infra=reserved:NoExecute

cat <<END > "${OCP_POST}/${user_workload_config}"
apiVersion: v1
kind: ConfigMap
metadata:
  name: user-workload-monitoring-config
  namespace: openshift-user-workload-monitoring
data:
  config.yaml: |
    prometheusOperator:
      nodeSelector:
        ${monitoring_node_selector}: ''
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    prometheus:
      retention: ${prometheus_retention}
      volumeClaimTemplate:
        metadata:
          name: prometheus
        spec:
          storageClassName: ${prometheus_stroageclass}
          resources:
            requests:
              storage: ${prometheus_storage_size}
      nodeSelector:
        ${monitoring_node_selector}: ''
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
    thanosRuler:
      nodeSelector:
        ${monitoring_node_selector}: ''
      tolerations:
      - key: "infra"
        value: "reserved"
        effect: "NoSchedule"  
      - key: "infra"
        value: "reserved"
        effect: "NoExecute"
END
