include_recipe 'java::default'
include_recipe 'maven::default'

user 'foobarbaz'

%w(/usr/local/notifyOne /usr/local/notifyTwo /usr/local/foobar/lib/mysql-connector-java-5.1.19.jar).each do |fname|
  file fname do
    action         :delete
    ignore_failure true
  end
end

file '/usr/local/notifyOne' do
  content 'I was notified'
  action  :nothing
end

file '/usr/local/notifyTwo' do
  content 'I was notified'
  action  :nothing
end

# Basic test
maven_artifact 'mysql-connector-java' do
  group_id 'mysql'
  version  '5.1.19'
  mode     '0755'
  owner    'foobarbaz'
  destination     '/usr/local/foobar/lib/'
  notifies :create, 'file[/usr/local/notifyOne]'
end

maven_artifact 'otherNameThanBefore' do
  artifact_id 'mysql-connector-java'
  group_id    'mysql'
  version     '5.1.19'
  mode        '0755'
  owner       'foobarbaz'
  destination        '/usr/local/foobar/lib/'
  notifies    :create, 'file[/usr/local/notifyTwo]'
end

# Test from alternate repo
maven_artifact 'java persistence library'  do
  artifact_id  'javax.persistence'
  group_id     'org.eclipse.persistence'
  version      '2.0.0'
  repositories %w(http://mirrors.ibiblio.org/pub/mirrors/maven2/)
  destination '/usr/local/foobar/lib'
end

# test from multiple repositories
maven_artifact 'postgresql' do
  group_id 'postgresql'
  version  '9.0-801.jdbc4'
  destination '/usr/local/foobar/lib'
  repositories [
    'http://mirrors.ibiblio.org/pub/mirrors/maven2/',
    'http://repo1.maven.apache.org/maven2'
  ]
end

# Test downloading hudson plugin and use old alias
maven_artifact 'mm-mysql'  do
  group_id   'mm-mysql'
  version   '2.0.13'
  packaging 'pom'
  destination '/usr/local/foobar/lib'
end
