# maven

- `artifact_id` - if this is not specified, the resource's name is used
- `group_id` - group_id for the artifact
- `version` - version of the artifact
- `dest` - the destination folder for the jar and its dependencies
- `packaging` - defaults to 'jar'
- `classifier` - distinguishes artifacts that were built from the same POM but differ in context
- `repositories` - array of maven repositories to use, defaults to `["<http://repo1.maven.apache.org/maven2>"]`
- `owner` - the owner of the resulting file, default is root
- `group` - the group of the resulting file, default is root's group
- `mode` - integer value for file permissions, default is 0644
- `transitive` - whether to resolve dependencies transitively, defaults to false. Please note: Event true will only place one artifact in dest. All others are downloaded to the local repository.
- `timeout` - sets the timeout (in seconds) of file download, default is 600

## Examples

```ruby
maven 'mysql-connector-java' do
  group_id 'mysql'
  version  '5.1.19'
  dest     '/usr/local/tomcat/lib/'
end
# The artifact will be downloaded to /usr/local/tomcat/lib/mysql-connector-java-5.1.19.jar

maven 'solr' do
  group_id  'org.apache.solr'
  version   '3.6.1'
  packaging 'war'
  dest      '/usr/local/tomcat/webapps/'
  action    :put
end
# The artifact will be downloaded to /usr/local/tomcat/webapps/solr.war

maven 'custom-application' do
  group_id   'com.company.name'
  version    '2.0.0'
  dest       '/usr/local/tomcat/lib'
  classifier 'client'
  action     :put
end
# The artifact will be downloaded to /usr/local/tomcat/lib/custom-application-2.0.0-client.jar
```
