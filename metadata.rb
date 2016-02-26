name             'maven'
maintainer       'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license          'Apache 2.0'
description      'Installs Apache Maven includes a resource for installing artifacts from maven'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.1'

depends 'ark',  '>= 1.0'
depends 'java', '>= 1.38'
depends 'windows', '>= 1.39.1'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'
supports 'windows'

source_url 'https://github.com/chef-cookbooks/maven' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/maven/issues' if respond_to?(:issues_url)
