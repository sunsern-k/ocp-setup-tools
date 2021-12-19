echo "Copying the bootstrap.ign to the $helper server.."

http_dir=/var/www/html/$clustername

[ ! -d $http_dir ] && sudo mkdir $http_dir

sudo cp ${OCP_DIR}/bootstrap.ign $http_dir
sudo chmod 766 -R $http_dir
sudo ls -l $http_dir/bootstrap.ign

echo "Create the append-boottrap.ign.."

cat <<END > ${OCP_DIR}/append-bootstrap.ign
{
  "ignition": {
      "config": {
          "merge": [
              {
                  "source": "http://${HTTP_HOST}/$clustername/bootstrap.ign",
                  "verification": {}
              }
          ]
      },
      "timeout": {},
      "version": "3.2.0"
  },
  "networkd": {},
  "passwd": {},
  "storage": {},
  "systemd": {}
}
END

cat $OCP_DIR/append-bootstrap.ign

echo "Creating the based64-encoded append-bootstrap.."
cat ${OCP_DIR}/append-bootstrap.ign | base64 -w0 > ${OCP_DIR}/append-bootstrap.64
ls -l ${OCP_DIR}/append-bootstrap*
