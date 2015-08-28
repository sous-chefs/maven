#
# Cookbook: maven
# License: Apache 2.0
#
# Copyright 2010-2013, Chef Software, Inc.
# Copyright 2015, Bloomberg Finance L.P.
#
default['maven']['version'] = '3.3.3'
default['maven']['remote_url'] = "http://apache.mirrors.tds.net/maven/maven-%{major_version}/%{version}/binaries/apache-maven-%{version}-bin.tar.gz" # rubocop:disable Style/StringLiterals
default['maven']['remote_checksum'] = '3a8dc4a12ab9f3607a1a2097bbab0150c947ad6719d8f1bb6d5b47d0fb0c4779'

default['maven']['extract_to'] = '/opt'

default['maven']['mavenrc']['M2_HOME'] = '/usr/local/maven'
default['maven']['mavenrc']['MAVEN_OPTS'] = '-Dmaven.repo.local=$HOME/.m2/repository'

default['maven']['repositories'] = ['http://repo1.maven.apache.org/maven2']
