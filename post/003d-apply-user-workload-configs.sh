if [ -f ${user_workload_config} ]
then
  echo "Applying ${user_workload_config}..."
  oc apply -f  ${user_workload_config}
else
  echo "[Skipped]: Unable to find the user workload config"
fi
