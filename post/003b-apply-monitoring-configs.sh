if [ -f ${cluster_monitoring_config} ]
then
  echo "Applying ${cluster_monitoring_config}..."
  oc apply -f  ${cluster_monitoring_config}
else
  echo "[Warning]: Unable to find ${cluster_monitoring_config}"
fi
