# maven Cookbook CHANGELOG

This file is used to list changes made in each version of the maven cookbook.

## 5.0.1 (2017-05-28)

- Close settings.xml file after writing.
- Increase requirement to 12.6+ as we can't use action_class.class_eval at this point

## 5.0.0 (2017-04-26)

- Add new setup_bin attribute to allow you to skip adding mvn to the system's path
- Test with delivery local mode
- Convert default LWRP to a custom resource
- Fix readme formatting
- Use Maven 3.5.0 by default
- Fix Chef 13 compat + why-run support in settings LWRP

## 4.0.1 (2016-12-06)

- Change provider so it only notifies when the artifact actaully changes
- Add a matcher for the settings resource
- Set the name property using the DSL
- Properly set the repositories from attribute in the provider

## 4.0.0 (2016-09-16)

- Force update when downloading snapshots
- Require Chef 12.1+
- Testing updates

## 3.0.0 (2016-09-03)

- Resolve rubocop warnings
- Add use_inline_resources to the providers
- Testing updates
- Use inspec and remove apt cookbook from testing
- Require Chef 12
- Remove the Windows cookbook dep which isn't needed in Chef 12

## v2.2.0 (2016-04-04)

- Add timeout value to the maven resource
- Cleanup to how the default action is set in the maven resource
- Require a modern Windows cookbook as there are issues with the older releases

## v2.1.1 (2016-02-16)

- Increase the ark version pin to ~1.0 to bring in the last 2 years of ark changes
- Require the latest java cookbook to fix install issues on Ubuntu/Debian and to support the latest OpenJDK releases
- Updated all testing dependencies
- Updated the platforms that are tested in Test Kitchen

## v2.1.0 (2015-11-25)

- Added a new settings LWRP for updating maven settings. See the readme for details
- Add the group lwrp property to the readme

## v2.0.1 (2015-11-16)

- Added Chefspec matchers
- Updated the LWRP with a new attribute `group` that defaults to node['root_group'] which enables support for platforms such as FreeBSD and OS X where root's group is not root.

## v2.0.0 (2015-11-16)

BREAKING CHANGES:

- Support for Maven 2 has been removed. In doing so the attribute structure has been changed.  The `version` attribute now has the complete version string not just the major version.  The `url` and 'checksum' attributes are now top level attributes instead of being under the individual maven versions.  See the readme for the up to date attribute structure.
- Java is no longer installed by this cookbook.  Maven 3 requires JRE 8, which may require installing Oracle Java depending on the age of your platform. The user need to handle the installation of Java by using the java cookbook or their own wrapper cookbook.

## v1.3.1

NOTE: This will be the last release with Maven 2 support

- Added requirements section to the readme to clarify what distros are supported and the requirement of Chef 11+
- Updated .gitignore file
- Added Chef standard Rubocop config
- Updated Travis CI testing to use Chef DK
- Updated Berksfile to 3.x format
- Removed the version pin on apt in the Berksfile
- Updated Gemfile with the latest development dependencies
- Updated contributing and testing docs
- Added maintainers.md and maintainers.toml files
- Added Travis and cookbook version badges to the readme
- Added a Rakefile for simplified testing
- Added a Chefignore file
- Resolved Rubocop warnings
- Added source_url and issues_url to the metadata

## v1.3.0

- Adding Windows support

## v1.2.0

- Adding flag to allow Java not to be managed by cookbook

## v1.1.0

- [COOK-3849] - Update maven 3 to 3.1.1

## v1.0.0

### Improvement

- **[COOK-3470](https://tickets.chef.io/browse/COOK-3470)** - Improve `/etc/mavenrc` template
- **[COOK-3459](https://tickets.chef.io/browse/COOK-3459)** - Install Maven 3.1.0 by default

## v0.16.4

### Improvement

- **[COOK-3352](https://tickets.chef.io/browse/COOK-3352)** - Improve `repository_root` attribute customization

### Bug

- **[COOK-2799](https://tickets.chef.io/browse/COOK-2799)** - Fix idempotency in LWRP

## v0.16.2

The following changes were originally released as 0.16.0, but the README incorrectly referred to the maven# recipes, which are now removed.

### Task

- [COOK-1874]: refactor maven default recipe to use version attributes

### Bug

- [COOK-2770]: maven cookbook broken for maven3 now that maven 3.0.5 has been released

## v0.15.0

- [COOK-1336] - Make Transitive Flag Configurable

## v0.14.0

- [COOK-2191] - maven3 recipe's "version" doesn't match the attributes
- [COOK-2208] - Add 'classifier' attribute to maven cookbook

## v0.13.0

- [COOK-2116] - maven should be available on the path

## v0.12.0

- [COOK-1860] - refactor maven provider to use resources and `shell_out`

## v0.11.0

- [COOK-1337] - add put action to maven lwrp to control name of the downloaded file
- [COOK-1657] - fix download urls

## v0.3.0

- [COOK-1145] - maven lwrp to download artifacts
- [COOK-1196] - convert lwrp attributes to snake_case
- [COOK-1423] - check version attribute in default recipe

## v0.2.0

- [COOK-813] - installs maven2 and maven3 using the binaries from maven.apache.org
