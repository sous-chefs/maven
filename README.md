Description
===========

Install and configure maven2 and maven3 from the binaries provided by
the maven project

Has `maven` LWRP for pulling a maven artifact from a maven repository and
placing it in an arbitrary location.

Has `maven_repo` LWRP that allows you to add your custom repo to the list
of repos searched for artifacts

Requirements
============

Platform:

* Debian, Ubuntu, CentOS, Red Hat, Fedora, OS X

The following Opscode cookbooks are dependencies:

* java - this cookbook not only depends on the java virtual machine
  but it also depends on the java_ark LWRP present in the java cookbooks
* ark - used to unpack the maven tarball

The following community cookbooks are dependencies:

* homebrew - this cookbook adds homebrew as a provider for the package resource.

Attributes
==========

* default['maven']['version']  defaults to 2
* default['maven']['2']['home']  defaults to  '/usr/local/maven/'
* default['maven']['2']['url']  the download url for maven2
* default['maven']['2']['checksum']  the checksum, which you will have
 to recalculate if you change the download url
* default['maven']['3']['home']  defaults to  '/usr/local/maven/'
* default['maven']['3']['url'] download url for maven3
* default['maven']['3']['checksum'] the checksum, which you will have
 to recalculate if you change the download url

[In Mac OS X only]

* default['maven']['version']  defaults to 3.0.4
* default['maven']['opts'] will be exported as an environment variable, $MAVEN_OPTS, in your shell's profile if not nil
* default['maven']['home'] defaults to Homebrew's install directory
* default['maven']['settings'] Attributes defined under 'settings' will be converted to xml for $MAVEN_HOME/conf/settings.xml, provided the contained data structure is set up properly. See below for examples.
* default['maven']['mirrors'] defaults to nil, which means no mirrors are defined. To define mirrors in your settings.xml, follow this format:

```json
[{"mirror": {"id": "nexus", "mirrorOf": "*", "url": "http:..."}}]
```

This will generate xml that looks like this (provided no other fields under 'settings' are provided):

```xml
<settings>
  <mirrors>
    <mirror>
      <id>
        nexus
      </id>
      <mirrorOf>
        *
      </mirrorOf>
      <url>
        http:...
      </url>
    </mirror>
  </mirrors>
</settings>
```

* default['maven']['profiles'] operates similarly to 'mirrors', above.  For example:

```json
[{"profile": {"id": "nexus", 
              "repositories": [{"repository": {"id": "riot", 
                                               "url": "http:...",
                                               "releases": [{"enabled": true}],
                                               "snapshots": [{"enabled": true}]}
                               }],
              "pluginRepositories": [{"pluginRepository": {"id": "riot",
                                                           "url": "http:...",
                                                           "releases": [{"enabled": true}],
                                                           "snapshots": [{"enabled": true}]}
                                    }]}
}]
```

will generate the following xml:

```xml
<settings>
  <profiles>
    <profile>
      <id>
        nexus
      </id>
      <repositories>
        <repository>
          <id>
            riot
          </id>
          <url>
            http:...
          </url>
          <releases>
            <enabled>
              true
            </enabled>
          </releases>
          <snapshots>
            <enabled>
              true
            </enabled>
          </snapshots>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>
            riot
          </id>
          <url>
            http:...
          </url>
          <releases>
            <enabled>
              true
            </enabled>
          </releases>
          <snapshots>
            <enabled>
              true
            </enabled>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
</settings>
```

* default['maven']['settings']['activeProfiles'] also works in the above manner:

```json
[{"activeProfile": "nexus"}, {"activeProfile": "otherProfile"}]
```

will generate

```xml
<settings>
  <activeProfiles>
    <activeProfile>
      nexus
    </activeProfile>
    <activeProfile>
      otherProfile
    </activeProfile>
  </activeProfiles>
</settings>
```

Note that all three of the above xml generators will combine into a single `<settings>` entry in $MAVEN_HOME/conf/settings.xml

Usage
=====

Simply include the recipe where you want Apache Maven installed.


Providers/Resources
===================

maven
-----

* artifact_id: if this is not specified, the resource's name is used
* group_id: group_id for the artifact
* version: version of the artifact
* dest: the destination folder for the jar and its dependencies
* packaging: defaults to 'jar'
* repositories: array of maven repositories to use, defaults to
 ["http://repo1.maven.apache.org/maven2"]
* owner: the owner of the resulting file, default is root
* mode: integer value for file permissions, default is 0644


# Examples

    maven "mysql-connector-java" do
      group_id "mysql"
      version "5.1.19"
      dest "/usr/local/tomcat/lib/"
    end

maven_repo
----------

TODO, coming soon

License and Author
==================

Author:: Seth Chisamore (<schisamo@opscode.com>)
Author:: Bryan W. Berry (<bryan.berry@gmail.com>)

Copyright 2010-2012, Opscode, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
