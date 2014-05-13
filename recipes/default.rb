#
# Cookbook Name:: ejabberd
# Recipe:: default
#
# Copyright (C) 2013 Mojo Lingo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# user 'ejabberd' do
#   comment 'ejabberd'
#   gid 'ejabberd'
#   home '/var/lib/ejabberd'
#   shell '/sbin/nologin'
# end
#
# include_recipe 'build-essential'
# include_recipe 'erlang'
#
# %w(
#   expat-devel
#   libyaml-devel
#   openssl-devel
# ).each do |pkg|
#   package pkg
# end
#
# git '/usr/local/src/ejabberd' do
#   repository node[:ejabberd][:repo]
#   reference node[:ejabberd][:version]
#   action :sync
#   # notifies :run, "bash[compile_app_name]"
# end
#
# %w(
#   cache_tab
#   tls
#   stringprep
#   xml
#   pgsql
#   zlib
# ).each do |dep|
#   git '/usr/local/src/ejabberd/deps/p1_' + dep do
#     repository 'https://github.com/processone/' + dep
#     action :sync
#   end
# end
#
# git '/usr/local/src/ejabberd/deps/esip'do
#   repository 'https://github.com/processone/p1_sip'
#   action :sync
# end
#
# git '/usr/local/src/ejabberd/deps/p1_yaml' do
#   repository 'https://github.com/processone/p1_yaml'
#   action :sync
# end
#
# git '/usr/local/src/ejabberd/deps/xmlrpc'do
#   repository 'https://github.com/rds13/xmlrpc'
#   action :sync
# end
#
# git '/usr/local/src/ejabberd/deps/lager'do
#   repository 'https://github.com/basho/lager'
#   action :sync
# end
#
# git '/usr/local/src/ejabberd/deps/goldrush'do
#   repository 'https://github.com/DeadZen/goldrush'
#   reference '0.1.6'
#   action :sync
# end
#
# git '/usr/local/src/ejabberd/deps/p1_iconv'do
#   repository 'https://github.com/processone/eiconv'
#   action :sync
# end
#
# bash "install_ejabberd" do
#   cwd "/usr/local/src/ejabberd"
#   code <<-EOH
#     ./configure --enable-zlib --enable-pgsql --prefix=/opt/ejabberd --enable-user=ejabberd
#     make
#     make install
#     EOH
# end

case node['platform']
when 'ubuntu', 'debian'
  include_recipe 'apt'
when 'centos', 'redhat', 'amazon', 'scientific'
  include_recipe 'yum-epel'
end

package 'ejabberd'

service 'ejabberd' do
  action :enable
end

template '/etc/ejabberd/ejabberd.cfg' do
  source 'ejabberd.cfg.erb'
  group 'ejabberd'
  mode '755'
  variables jabber_domain: node['ejabberd']['jabber_domain']
  notifies :restart, resources('service[ejabberd]')
end
