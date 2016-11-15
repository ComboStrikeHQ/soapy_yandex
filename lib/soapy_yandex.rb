# frozen_string_literal: true
require 'httparty'
require 'openssl'
require 'ox'
require 'securerandom'

require 'soapy_yandex/client'
require 'soapy_yandex/error'
require 'soapy_yandex/money_client'
require 'soapy_yandex/request'
require 'soapy_yandex/response'
require 'soapy_yandex/version'

module SoapyYandex
  CURRENCY_DEMO_RUBLES = 10643
  CURRENCY_RUBLES = 643
end
