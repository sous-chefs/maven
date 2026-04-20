# maven Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/maven.svg)](https://supermarket.chef.io/cookbooks/maven)
[![CI State](https://github.com/sous-chefs/maven/workflows/ci/badge.svg)](https://github.com/sous-chefs/maven/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Custom resources for installing Apache Maven, downloading Maven artifacts, and
editing `settings.xml`.

Use the custom resources directly:

- `maven_install`
- `maven_artifact`
- `maven_settings`

This cookbook does not install Java. Ensure a compatible JDK is present before
using the `mvn` binary or `maven_artifact`.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community
of Chef cookbook maintainers working together to maintain important cookbooks.
If you'd like to know more please visit [sous-chefs.org](https://sous-chefs.org/)
or come chat with us on the Chef Community Slack in
[#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

The cookbook metadata currently supports:

- AlmaLinux 9+
- Amazon Linux 2023+
- Debian 12+
- Debian 13+
- Fedora
- Rocky Linux 9+
- Ubuntu 22.04+

### Chef

- Chef Infra Client 16+

### Cookbooks

- `ark` 5.0+

## Resource Overview

### `maven_install`

Installs Apache Maven from the upstream binary tarball, manages the Maven home,
and writes a `mavenrc` file with `M2_HOME` and `MAVEN_OPTS`.

```ruby
maven_install 'default' do
  version '3.9.14'
end
```

### `maven_artifact`

Downloads an artifact from one or more remote repositories by invoking the
Maven dependency plugin through `mvn`.

```ruby
maven_artifact 'mysql-connector-j' do
  group_id 'com.mysql'
  version '8.4.0'
  dest '/opt/app/lib'
end
```

### `maven_settings`

Updates a value in an existing `settings.xml` file by dotted path.

```ruby
maven_settings 'settings.localRepository' do
  value '/srv/maven-repository'
end
```

## Usage

Install a supported JDK first, then declare the resources you need in your own
wrapper cookbook. A typical flow is:

1. Install Java with your preferred cookbook or base image.
2. Use `maven_install` to place Maven on the node.
3. Use `maven_settings` to adjust `settings.xml` if needed.
4. Use `maven_artifact` to fetch application dependencies or deployment assets.

See `test/cookbooks/test/recipes/default.rb` for the full default-suite example
that exercises all three resources together.

## Resource Documentation

- [maven_install](./documentation/maven_install.md)
- [maven_artifact](./documentation/maven_artifact.md)
- [maven_settings](./documentation/maven_settings.md)

## Limitations

See [LIMITATIONS.md](./LIMITATIONS.md) for supported platforms, architecture
notes, and current behavioral constraints of the resources.

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a
link to your website.

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
