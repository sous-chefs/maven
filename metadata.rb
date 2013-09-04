name             "maven"
maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs maven 2 or 3 and includes a maven resource."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.16.5"

depends "java"
depends "ark", "< 0.2.0" # restriction due to [COOK-3118] 
                         # (this problem will be fixed in upcoming ark 0.3.1)

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end

