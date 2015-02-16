action :create do
  Chef::Log.info "Creating hdfs directory: #{@new_resource.name}"

  bash "mk-dir-#{new_resource.name}" do
    user node[:hdfs][:user]
    code <<-EOF
     set -e
     . #{node[:hadoop][:home]}/sbin/set-env.sh
     #{node[:hadoop][:home]}/bin/hdfs dfs -mkdir -p #{new_resource.name}
     #{node[:hadoop][:home]}/bin/hadoop fs -chmod #{new_resource.mode} #{new_resource.name} 
     #{node[:hadoop][:home]}/bin/hadoop fs -chown -R #{new_resource.owner}:#{new_resource.group} #{new_resource.name} 
    EOF
    not_if ". #{node[:hadoop][:home]}/sbin/set-env.sh"
  end
 
end
