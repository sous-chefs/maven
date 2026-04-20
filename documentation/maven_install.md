# maven_install

Install Apache Maven from the upstream binary tarball and manage the local
environment file used to expose `M2_HOME` and `MAVEN_OPTS`.

## Actions

| Action | Description |
|--------|-------------|
| `:install` | Install Maven and write the `mavenrc` file. Default action. |
| `:remove` | Remove the `mavenrc` file, install directory, and `/usr/local/bin/mvn` symlink if present. |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `install_name` | String | name property | Identifier for the installation. |
| `version` | String | `'3.9.14'` | Apache Maven version to install. |
| `url` | String | `nil` | Override URL for the Maven binary tarball. |
| `checksum` | String | `nil` | SHA256 checksum for the tarball. Provide this when overriding `url`. |
| `install_dir` | String | `'/usr/local/maven'` | Directory where Maven is installed. |
| `user` | String | `'root'` | Owner of the install directory and `mavenrc` file. |
| `group` | String | `'root'` | Group owner of the install directory and `mavenrc` file. |
| `mavenrc_path` | String | `'/etc/mavenrc'` | Path to the environment file that exports `M2_HOME` and `MAVEN_OPTS`. |
| `maven_opts` | String | `'-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m'` | Value written to `MAVEN_OPTS`. |
| `manage_user` | TrueClass, FalseClass | `false` | Create the `user` and `group` if they do not already exist. |
| `append_env_path` | TrueClass, FalseClass | `true` | Expose `mvn` on the system `PATH` via `/usr/local/bin/mvn`. |

## Examples

### Install Maven with defaults

```ruby
maven_install 'default'
```

### Install a specific version in a custom location

```ruby
maven_install 'build-node' do
  version '3.9.14'
  install_dir '/opt/maven'
  mavenrc_path '/etc/profile.d/maven.sh'
  maven_opts '-Dmaven.repo.local=/var/cache/maven -Xmx512m'
end
```

### Create a dedicated service account for the install

```ruby
maven_install 'ci' do
  user 'maven'
  group 'maven'
  manage_user true
end
```

### Install from an alternate mirror

```ruby
maven_install 'internal-mirror' do
  version '3.9.14'
  url 'https://artifacts.example.com/apache-maven-3.9.14-bin.tar.gz'
  checksum '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
end
```
