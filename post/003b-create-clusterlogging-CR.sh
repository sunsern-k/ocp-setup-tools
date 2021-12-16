cat <<END >${OCP_POST}/${logging_config}
apiVersion: "logging.openshift.io/v1"
kind: "ClusterLogging"
metadata:
  name: "instance" 
  namespace: "openshift-logging"
spec:
  managementState: "Managed"  
  logStore:
    type: "elasticsearch"  
    retentionPolicy: 
      application:
        maxAge: 7d
      infra:
        maxAge: 7d
      audit:
        maxAge: 7d
    elasticsearch:
      nodeCount: 3 
      nodeSelector:
        ${logging_node_selector}: ''
      tolerations:
      - key: infra 
        value: reserved
        effect: NoSchedule
      - key: infra 
        value: reserved
        effect: NoExecute  
      storage:
        storageClassName: ${logging_storageclass}
        size: ${logging_storage_size} 
      resources: 
        limits:
          memory: "16Gi"
        requests:
          cpu: 500m
          memory: "16Gi"
      proxy: 
        resources:
          limits:
            memory: 256Mi
          requests:
             memory: 256Mi
      redundancyPolicy: "SingleRedundancy"
  visualization:
    type: "kibana"  
    kibana:
      resources: 
        limits:
          memory: 1Gi
        requests:
          cpu: 500m
          memory: 1Gi
      replicas: 1
      nodeSelector:
        ${logging_node_selector}: ''
      tolerations:
      - key: infra 
        value: reserved
        effect: NoSchedule
      - key: infra 
        value: reserved
        effect: NoExecute  
  collection:
    logs:
      type: "fluentd"  
      fluentd: 
        tolerations:
        - operator: "Exists"
END
