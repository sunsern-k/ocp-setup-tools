if [ -f "${OCP_POST}/${monitoring_config}" ]
then
  echo "Applying ${OCP_POST}/${monitoring_config}..."
  oc apply -f  ${OCP_POST}/${monitoring_config}
else
  echo "[Skipped]: Unable to find the cluster monitoring config"
fi
