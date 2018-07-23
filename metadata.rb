name             'maven'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache-2.0'
description      'Installs Apache Maven includes a resource for installing artifacts from maven'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '5.2.0'

depends 'ark',  '>= 1.0'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'
supports 'windows'

source_url 'https://github.com/chef-cookbooks/maven'
issues_url 'https://github.com/chef-cookbooks/maven/issues'
chef_version '>= 12.6' if respond_to?(:chef_version)
