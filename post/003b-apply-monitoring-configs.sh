if [ -f ${cluster_monitoring_config} ]
then
  echo "Applying ${cluster_monitoring_config}..."
  oc apply -f  ${cluster_monitoring_config}
else
  echo "[Skipped]: Unable to find the cluster monitoring config"
fi
