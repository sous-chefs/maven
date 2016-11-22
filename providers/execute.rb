def make_mvn_cmd(resource)
	%Q{mvn #{resource.goal} #{resource.opts}}
end

action :run do
	cmd = make_mvn_cmd(new_resource)
	execute new_resource.name do
		command	cmd
		cwd	new_resource.cwd
		group	new_resource.group
		timeout	new_resource.timeout
		user	new_resource.user
	end
end
				
