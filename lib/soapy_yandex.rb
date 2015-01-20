require 'httparty'
require 'openssl'
require 'ox'
require 'securerandom'

require 'soapy_yandex/version'
require 'soapy_yandex/error'
require 'soapy_yandex/request'
require 'soapy_yandex/response'
require 'soapy_yandex/client'
require 'soapy_yandex/money_client'

module SoapyYandex
  CURRENCY_DEMO_RUBLES = 10643
end
