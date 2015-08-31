# maven-cookbook
[Application cookbook][0] which installs and configures [Maven][1].

## Basic Usage
This cookbook provides a no-frills way to install and configure
Maven. It also provides two resources for installing artifacts and
executing arbitrary Maven commands. This cookbook assumes that Java
has already been installed on the system.

### Installing Java 1.8 and Maven
This version of the cookbook requires a minimum of Java 1.8 version in
order to use the default *maven_artifact* resource. In order to
provide the most flexibility this cookbook _does not_ install
Java. The community [Java cookbook][1] works very well for this.
```ruby
node.default['java']['jdk_version'] = '8'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default', 'maven::default'
```

### Downloading Maven Artifacts
If you're looking to download artifacts from a Maven repository
there is the *maven_artifact* resource which makes it easy to do
so. This resource shells out to the *maven_execute* resource and
utilizies the [maven dependency plugin][2] to recursively resolve
all dependencies of the specified artifact.
```ruby
maven_artifact 'spoon' do
  version '0.2.0-SNAPSHOT'
  group_id 'com.bloomberg.inf'
  repositories 'http://clojars.org/repo'
  destination '/usr/local/share/java'
end
```

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern#theapplicationcookbook
[1]: https://github.com/opscode-cookbooks/java/
[2]: https://maven.apache.org/plugins/maven-dependency-plugin/
