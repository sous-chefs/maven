# maven Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/maven.svg)](https://supermarket.chef.io/cookbooks/maven)
[![CI State](https://github.com/sous-chefs/maven/workflows/ci/badge.svg)](https://github.com/sous-chefs/maven/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Install and configure Apache Maven from the binaries provided by the Maven project.

Provides the `maven` resource for pulling a maven artifact from a maven repository and placing it in an arbitrary location.

Note: This cookbook does not handle the installation of Java but does require it to be installed. This can be done either using the [Java cookbook](https://supermarket.chef.io/cookbooks/java) or your own cookbook. Check the [Maven website](https://maven.apache.org/docs/history.html) for more information about explicit Java requirements.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle
- Fedora
- Windows

### Chef

- Chef 13+

### Cookbooks

- ark - used to unpack the maven tarball

## Attributes

- `node['maven']['version']` - specifies the version of maven to install.
- `node['maven']['m2_home']` - defaults to '/usr/local/maven/'
- `node['maven']['url']` - the download url for maven
- `node['maven']['checksum']` - the checksum, which you will have to recalculate if you change the download url using `shasum -a 256 FILENAME`
- `node['maven']['repositories']` - an array of maven repositories to use; must be specified as an array. Used in the maven LWRP.
- `node['maven']['setup_bin']` - whether or not to put mvn on your system path, defaults to false
- `node['maven']['mavenrc']['opts']` - value of `MAVEN_OPTS` environment variable exported via `/etc/mavenrc` template, defaults to `-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m`
- `node['maven']['user']` - User to own Maven install, defaults to `root` or `Administrator` depending on platform.
- `node['maven']['group']` - Group to own Maven install, defaults to `root` or `Administrators` depending on platform.

## Recipes

### default

Installs maven according to the version specified by the `node['maven']['version']` attribute.

### settings

Installs gems required to parse settings.xml to ruby and hash and back to xml

## Usage

Install a version of Java JRE (Oracle or OpenJDK) that is at minimum the version of Java required by the [maven release you are installing](https://maven.apache.org/docs/history.html). This can be done either using the [Java cookbook](https://supermarket.chef.io/cookbooks/java) or your own cookbook.

Include the recipe where you want Apache Maven installed.

The maven lwrp has two actions, `:install` and `:put`. They are essentially the same accept that the install action will name the the downloaded file `artifact_id-version.packaging`. For example, the mysql jar would be named mysql-5.1.19.jar.

Use the put action when you want to explicitly control the name of the downloaded file. This is useful when you download an artifact and then want to have Chef resources act on files within that the artifact. The put action will creat a file named `name.packaging` where name corresponds to the name attribute.

## Providers/Resources

## maven_settings

Resource provider for modifying the maven settings.

### Actions

Action | Description                                    | Default
------ | ---------------------------------------------- | -------
update | Updates a global maven setting to a new value. | Yes

### Attributes

Attribute | Description                                                                       | Type                                | Default
--------- | --------------------------------------------------------------------------------- | ----------------------------------- | -------
path      | Period '.' delimited path to element of the settings that is going to be changed. | String                              | name
value     | The new value to update the path to.                                              | String, TrueClass, FalseClass, Hash |

In order to use this resource you first need to run `settings` recipe which will installed required bury gems for you. Find below exampl on how to update proxy in settings.xml

```ruby
maven_settings "settings.proxies" do
  value "proxy" => {
    "active" => true,
    "protocaol" => "http",
    "host" => "proxy.myorg.com",
    "port" => 80,
    "nonProxyHosts" => ".myorg.com"
  }
end
```

### maven

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

#### Examples

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

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
