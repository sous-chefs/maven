require 'chefspec'
require_relative 'support/matchers/ark_matchers'
require 'chefspec/berkshelf'

at_exit { ChefSpec::Coverage.report! }
