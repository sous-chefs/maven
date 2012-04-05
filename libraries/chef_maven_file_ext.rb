#
# Cookbook Name:: maven
# Library:: chef_maven_file_ext
#
# Author:: Josiah Kiehl <josiah@skirmisher.net>
#
# Copyright 2011-2012, Riot Games

class Chef
  module Maven
    module FileExt
      def to_xml(data, depth = 0)
        return data if data.is_a? String
        data = data.to_a if data.is_a? Hash
        data.inject('') do |xml, setting|
          key, value = setting
          xml << (" "*(2*depth)) + "<#{key}>\n"
          xml << if value.is_a? Hash
                   to_xml(value, depth+1)
                 elsif value.is_a? Array
                   value.collect { |v| to_xml(v, depth+1) }.join
                 else
                   (" "*(2*depth)) + "  #{value}\n"
                 end
          xml << (" "*(2*depth)) + "</#{key}>\n"
        end
      end
    end
  end
end

Chef::Resource::File.send(:include, Chef::Maven::FileExt)
