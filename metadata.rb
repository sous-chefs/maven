name 'maven'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Application cookbook which installs and configures Maven.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

suggests 'java'
depends 'libarchive', '~> 0.6'
depends 'poise', '~> 2.2'
depends 'rc', '~> 1.1'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'ubuntu'
supports 'windows'
