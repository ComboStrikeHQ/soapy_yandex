# frozen_string_literal: true

require 'soapy_yandex'
require 'vcr'
require 'timecop'

ENV['YANDEX_SERVER'] ||= 'yandex-server'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('yandex-server') { ENV['YANDEX_SERVER'] }

  config.ignore_hosts 'codeclimate.com'
end
