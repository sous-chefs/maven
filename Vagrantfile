distros = {
  :lucid32 => {
    :url    => 'http://files.vagrantup.com/lucid32.box',
    :run_list => [ "apt" ]
  },
  :centos6_3_32 => {
    :url      => 'https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-centos-6.3-i386.box'
  }
}

Vagrant::Config.run do |config|
  distros.each_pair do |name,options|
    config.vm.define name do |dist_config|
      
      dist_config.vm.box = name.to_s
      dist_config.vm.box_url = options[:url]
      
      dist_config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ["/tmp/maven-cookbooks"]
        chef.provisioning_path = '/etc/vagrant-chef' 
        chef.log_level         = :debug		 
        chef.add_recipe "minitest-handler"
        chef.add_recipe "ark"
        chef.add_recipe "java"    
        chef.add_recipe "maven"
        chef.add_recipe "maven::test"
        if options[:run_list]
          options[:run_list].each {|recipe| chef.run_list.insert(0, recipe) }
        end
      end
    end
  end
end
