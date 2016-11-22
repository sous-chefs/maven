
actions :run
default_action :run

attribute :goal, kind_of: String, name_attribute: true, default: "install"
attribute :opts, kind_of: String, default: node["maven"]["mavenrc"]["opts"] 
attribute :cwd, kind_of: String
attribute :group, kind_of: [String, Integer]
attribute :path, kind_of: Array, default: Array.new
attribute :timeout, kind_of: Integer
attribute :user, kind_of: [String, Integer]

def initialize(*args)
	super
	@goal ||= @name
	@action = :run
end
