# 
LDAP_URL="ldaps://$ldapserver"
LDAP_PASSWORD="xxxx"
bind_dn="cn=xxx,ou=xxxx,dc=xxx,dc=xxx,dc=xxx"
search_base="ou=xxx,dc=xxxx,dc=xxxx,dc=xxxx"
ldapsearch -H $LDAP_URL -x -D "$bind_dn" -b "$search_base" "(objectClass=group)" -w "$LDAP_PASSWORD"