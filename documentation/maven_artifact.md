# maven_artifact

Download a Maven artifact from one or more remote repositories by invoking the
Maven dependency plugin through `mvn`.

## Actions

| Action     | Description                                                                            |
|------------|----------------------------------------------------------------------------------------|
| `:install` | Download the artifact to `dest` using the versioned artifact filename. Default action. |
| `:put`     | Download the artifact to `dest` using `resource_name.packaging` as the filename.       |
| `:delete`  | Remove both the versioned `:install` filename and the custom `:put` filename.          |

## Properties

| Property         | Type                  | Default                                     | Description                                                 |
|------------------|-----------------------|---------------------------------------------|-------------------------------------------------------------|
| `artifact_id`    | String                | name property                               | Maven `artifactId`.                                         |
| `group_id`       | String                | none                                        | Maven `groupId`.                                            |
| `version`        | String                | none                                        | Artifact version.                                           |
| `dest`           | String                | none                                        | Directory that receives the downloaded artifact.            |
| `packaging`      | String                | `'jar'`                                     | Artifact packaging such as `jar`, `war`, or `pom`.          |
| `classifier`     | String                | `nil`                                       | Optional artifact classifier.                               |
| `owner`          | String                | `'root'`                                    | Owner of the downloaded file.                               |
| `group`          | String                | `node['root_group']`                        | Group owner of the downloaded file.                         |
| `mode`           | Integer, String       | `'0644'`                                    | Mode of the downloaded file.                                |
| `repositories`   | Array                 | `['https://repo1.maven.apache.org/maven2']` | Remote repositories passed to Maven.                        |
| `transitive`     | TrueClass, FalseClass | `false`                                     | Whether Maven should resolve transitive dependencies.       |
| `timeout`        | Integer               | `600`                                       | Timeout for the `mvn` command, in seconds.                  |
| `plugin_version` | String                | `'3.6.1'`                                   | Version of `maven-dependency-plugin` used for the download. |

## Examples

### Download a JAR into an application lib directory

```ruby
maven_artifact 'mysql-connector-j' do
  group_id 'com.mysql'
  version '8.4.0'
  dest '/opt/myapp/lib'
end
```

### Download a WAR with a stable filename

```ruby
maven_artifact 'app' do
  artifact_id 'webapp'
  group_id 'com.example'
  version '2.7.3'
  packaging 'war'
  dest '/opt/tomcat/webapps'
  action :put
end
```

### Download a classified artifact from custom repositories

```ruby
maven_artifact 'acme-client' do
  group_id 'com.acme'
  version '1.5.0'
  classifier 'linux-x86_64'
  dest '/srv/acme'
  repositories [
    'https://repo1.maven.apache.org/maven2',
    'https://artifacts.example.com/maven'
  ]
end
```

### Fetch a snapshot and its transitive dependencies

```ruby
maven_artifact 'service-api' do
  group_id 'com.example'
  version '3.2.0-SNAPSHOT'
  dest '/srv/build-cache'
  transitive true
end
```
