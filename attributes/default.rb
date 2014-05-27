# default[:ejabberd][:version] = '14.05'
# default[:ejabberd][:repo] = 'https://github.com/processone/ejabberd.git'

default[:ejabberd][:admin] = 'admin'
default[:ejabberd][:adminpw] = 'secret'
default[:ejabberd][:domain] = 'ejabberd.example.com'
default[:ejabberd][:prefix] = '/opt/ejabberd'

default[:ejabberd][:jabber_domain] = node[:fqdn]

default[:ldap][:base] = 'dc=example,dc=com'
default[:ldap][:filter] = '(objectClass=shadowAccount)'
default[:ldap][:port] = '389'
default[:ldap][:servers] = 'ldap.example.com'
default[:ldap][:uids] = '{"mail", "%u@mail.example.org"}'
