maven 'mysql-connector-java' do
  group_id 'mysql'
  version  '5.1.19'
  dest     node['maven_test']['dest']
  owner    node['maven_test']['owner']
  group    node['maven_test']['group']
end
