if [ -f ${OCP_POST}/${user_workload_config} ]
then
  echo "Applying ${OCP_POST}/${user_workload_config}..."
  oc apply -f  ${OCP_POST}/${user_workload_config}
else
  echo "[Skipped]: Unable to find the user workload config"
fi
