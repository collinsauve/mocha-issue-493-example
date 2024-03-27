#!/usr/bin/env ruby
require 'minitest/autorun'
require 'mocha'
require 'mocha/minitest'
require_relative 'example'

class ExampleTest < Minitest::Test

  DOMAIN = 'example.com'
  TXT_RECORDS = ['hello', 'world']

  def test_get_txt
    records = TXT_RECORDS.map do |r|
      record = mock
      record.expects(:data).with.returns(r)
      record
    end

    dns = mock    
    dns.expects(:getresources).with(DOMAIN, Resolv::DNS::Resource::IN::TXT).returns(records)

    Resolv::DNS
      .expects(:open)
      .yields(dns)
      .returns(records) # I should not have to do this, and it allows bad implementations to not actually return the results properly

    result = Example.get_txt(DOMAIN)

    assert_equal TXT_RECORDS, result
  end
end
