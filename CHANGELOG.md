# maven Cookbook CHANGELOG

This file is used to list changes made in each version of the maven cookbook.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 6.0.12 - *2025-09-04*

## 6.0.11 - *2024-05-03*

## 6.0.10 - *2024-05-03*

## 6.0.9 - *2023-09-28*

## 6.0.8 - *2023-09-04*

## 6.0.7 - *2023-07-10*

## 6.0.6 - *2023-06-08*

Standardise files with files in sous-chefs/repo-management

## 6.0.5 - *2023-05-17*

## 6.0.4 - *2023-05-03*

## 6.0.3 - *2023-04-01*

## 6.0.2 - *2023-03-02*

## 6.0.1 - *2022-02-08*

- Remove delivery folder

## 6.0.0 - *2022-01-10*

- Enable unified_mode and require Chef >= 15.3
- resolved cookstyle error: providers/settings.rb:48:34 convention: `Style/FileRead`

## 5.4.2 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 5.4.1 (2021-06-01)

- Standardise files with files in sous-chefs/repo-management

## 5.4.0 (2020-11-04)

- Sous Chefs Adoption
- Update to use Sous Chefs GH workflow
- Update README to sous-chefs
- Update metadata.rb to Sous Chefs
- Update test-kitchen to Sous Chefs

### Fixed

- resolved cookstyle error: resources/default.rb:52:5 convention: `Style/RedundantAssignment`
- resolved cookstyle error: resources/default.rb:53:5 convention: `Layout/IndentationWidth`
- resolved cookstyle error: resources/default.rb:54:26 convention: `Layout/ElseAlignment`
- resolved cookstyle error: resources/default.rb:55:5 convention: `Layout/IndentationWidth`
- resolved cookstyle error: resources/default.rb:56:26 convention: `Layout/ElseAlignment`
- resolved cookstyle error: resources/default.rb:57:5 convention: `Layout/IndentationWidth`
- resolved cookstyle error: resources/default.rb:58:26 warning: `Layout/EndAlignment`
- resolved cookstyle error: resources/default.rb:59:1 convention: `Layout/EmptyLinesAroundMethodBody`
- resolved cookstyle error: resources/default.rb:59:1 convention: `Layout/TrailingWhitespace`
- resolved cookstyle error: resources/default.rb:28:42 refactor: `ChefCorrectness/LazyEvalNodeAttributeDefaults`
- Yamllint fixes

- Add default .mdlrc
- Add missing platforms to dokken

### Removed

- Remove EL 6 testing

## 5.3.0 (2019-10-07)

- Cookstyle fixes - [@tas50](https://github.com/tas50)
- Update for Chef 15 license agreement and Chef Workstation - [@tas50](https://github.com/tas50)
- Style fixes - [@tas50](https://github.com/tas50)
- Resolve Cookstyle 5.8 warnings and require Chef 13+ - [@tas50](https://github.com/tas50)

## 5.2.0 (2018-07-23)

- Remove ChefSpec matchers that are auto generated now
- Verify install_ark resource is correctly called
- Add ability to install Maven under different user/group and auto create that user/group

## 5.1.0 (2017-11-28)

- Update version of maven installed
- Remove java dependency (add to test cookbook)

## 5.0.3 (2017-11-01)

- Fix the archive URL for realz this time

## 5.0.2 (2017-11-01)

- Update the default maven URL to use the apache.org archive site since the binary has been moved off the main site

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

- **[COOK-3470](https://tickets.chef.io/browse/COOK-3470)** - Improve `/etc/mavenrc` template
- **[COOK-3459](https://tickets.chef.io/browse/COOK-3459)** - Install Maven 3.1.0 by default

## v0.16.4

- **[COOK-3352](https://tickets.chef.io/browse/COOK-3352)** - Improve `repository_root` attribute customization
- **[COOK-2799](https://tickets.chef.io/browse/COOK-2799)** - Fix idempotency in LWRP

## v0.16.2

The following changes were originally released as 0.16.0, but the README incorrectly referred to the maven# recipes, which are now removed.

- [COOK-1874]: refactor maven default recipe to use version attributes
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
