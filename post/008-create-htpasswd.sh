# Update a list of users in the htpasswd_env

# It accepts the first parameter as a file containing a list of users
# The example of a file is htpasswd_users.example
htpasswd_user_input=$1

# A htpasswd file to be created as a secret in OpenShift
htpasswd_file="htpasswd-secret"

# OAuth config file
oauth_config="htpasswd-local.yaml"

# If the parameter is passed for the htpasswd file then overide the default "http_env" file
if [ "$htpasswd_user_input" = "" ]
then
  # If do not supply another file, the default htpasswd_users are used
  htpasswd_source="htpasswd_users"
else
  htpasswd_source="$htpasswd_user_input"
fi

# Verify that the htpasswd exists
which htpasswd 1>/dev/null 2>/dev/null

if [ ! "$?" = "0" ]
then
  sudo yum install httpd-tools -y
fi

[ ! -f $htpasswd_file ] && touch $htpasswd_file

if [ -f $htpasswd_source ]
then
  source=$(cat $htpasswd_source | egrep -v "^#")

  echo "$source" | while read line
  do 
    u=$(echo "$line" | awk '{print $1}') 
    p=$(echo "$line" | awk '{print $2}') 

    # Do not accept a blank password
    if [ ! "$p" = "" ]
    then
      htpasswd -B -b $htpasswd_file $u $p
    else
      echo "The password of $u user is blank; skipped"
      continue
    fi
  done
else
  echo "Usage: $0 [<htpasswd_users_file> or create a default htpaswd_users]" 
fi

echo "Creating a htpasswd secret from ${htpasswd_file}..."
oc create secret generic htpasswd-secret --from-file=htpasswd=$htpasswd_file -n openshift-config


# Create HTPasswd Identity Provider
echo "Creating OAuth configration for the htpasswd..."

cat <<END > $oauth_config
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
  - name: Local Password
    mappingMethod: claim
    type: HTPasswd
    htpasswd:
      fileData:
        name: htpasswd-secret
END

[ -f $oauth_config ] && oc apply -f $oauth_config
