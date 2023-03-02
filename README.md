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

- [maven](./documentation/maven.md)
- [maven_settings](./documentation/maven_settings.md)

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
