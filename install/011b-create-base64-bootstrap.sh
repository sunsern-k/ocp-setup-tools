echo "Copying the bootstrap.ign to the $helper server.."

http_dir=/var/www/html/$clustername
append_dir=$HOME/$clustername

[ ! -d $http_dir ] && mkdir $http_dir && chmod 644 $http_dir
[ ! -d $append_dir ] && mkdir $append_dir

sudo cp ${OCP_DIR}/bootstrap.ign $http_dir
sudo chmod 644 $http_dir/*
sudo ls -l $http_dir/bootstrap.ign

echo "Create the append-boottrap.ign.."

cat <<END > $append_dir/append-bootstrap.ign
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
      "version": "3.1.0"
  },
  "network": {},
  "passwd": {},
  "storage": {},
  "systemd": {}
}
END

cat $append_dir/append-bootstrap.ign

echo "Creating the based64-encoded append-bootstrap.."
cat $append_dir/append-bootstrap.ign | base64 -w0 > $append_dir/append-bootstrap.64
ls -l $append_dir/append-bootstrap*
