# default[:ejabberd][:version] = '14.05'
# default[:ejabberd][:repo] = 'https://github.com/processone/ejabberd.git'

default[:ejabberd][:admin] = 'admin'
default[:ejabberd][:adminpw] = 'secret'
default[:ejabberd][:domain] = 'ejabberd.example.com'
default[:ejabberd][:prefix] = '/opt/ejabberd'

default[:ejabberd][:jabber_domain] = node[:fqdn]
