# This is an optional recipe that provides monit monitoring of your riak node. Requires the monit cookbook.

include_recipe "monit::default"

directory "/etc/monit/bin" do
  owner "root"
  group "root"
  mode 0755
  action :create
  recursive true
end

file "/etc/monit/bin/riak-check.sh" do
  owner "root"
  group "root"
  mode 0755
  content <<-EOS
#!/bin/bash
/usr/sbin/riak ping
exit $?
EOS
  action :create
end

monitrc "riak" do
  variables(
    :start_program => node[:riak][:monit][:start_program]
  )
  template_source "riak-monit.conf.erb"
  template_cookbook "riak"
end
