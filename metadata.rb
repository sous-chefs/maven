name             'maven'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache 2.0'
description      'Installs Apache Maven includes a resource for installing artifacts from mave.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.1'

depends 'ark',  '~> 0.9'
depends 'java', '~> 1.13'
depends 'windows'

supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'ubuntu'
supports 'windows'

source_url 'https://github.com/chef-cookbooks/maven' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/maven/issues' if respond_to?(:issues_url)
