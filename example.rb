#!/usr/bin/env ruby
require 'resolv'

class Example
  def self.get_txt(domain)    
    resources =
      Resolv::DNS.open do |dns|
        dns.getresources(domain, Resolv::DNS::Resource::IN::TXT)
      end

    resources.map { |r| r.data }
  end
end

if __FILE__ == $PROGRAM_NAME
  puts Example.get_txt('google.com')
end