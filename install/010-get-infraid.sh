export infraid=$(jq -r .infraID ${OCP_DIR}/metadata.json)
echo "jq -r .infraID ${OCP_DIR}/metadata.json" > get_infraid.sh; chmod 754 get_infraid.sh
echo $infraid
