# frozen_string_literal: true

name 'maven'

run_list 'test::default'

cookbook 'maven', path: '.'
cookbook 'ark', git: 'https://github.com/sous-chefs/ark.git', branch: 'main'
cookbook 'seven_zip', git: 'https://github.com/sous-chefs/seven_zip.git', branch: 'main'
cookbook 'test', path: './test/cookbooks/test'

Dir.children('./test/cookbooks/test/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, 'test::' + recipe_name
end
