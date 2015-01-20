# SoapyYandex

[![Circle CI](https://circleci.com/gh/ad2games/soapy_yandex/tree/master.svg?style=svg&circle-token=8be9c1e0316a8b902677fde68be9587af8926915)](https://circleci.com/gh/ad2games/soapy_yandex/tree/master)
[![Code Climate](https://codeclimate.com/repos/54b7e4e9695680436f000d5d/badges/70ac279dcc117a7ea246/gpa.svg)](https://codeclimate.com/repos/54b7e4e9695680436f000d5d/feed)
[![Test Coverage](https://codeclimate.com/repos/54b7e4e9695680436f000d5d/badges/70ac279dcc117a7ea246/coverage.svg)](https://codeclimate.com/repos/54b7e4e9695680436f000d5d/feed)

Client library for Yandex Money.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'soapy_yandex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soapy_yandex

## Usage

```ruby
# Create a new client instance
client = SoapyYandex::MoneyClient.new(
  server: ENV['YANDEX_SERVER'],
  ssl_cert: File.read('cert.pem'),
  ssl_key: File.read('key.pem'),
  remote_cert: File.read('remote_cert.pem'),
  ssl_key_passphrase: ENV['SSL_KEY_PASSPHRASE'],
)

# Get account balance
result = client.balance(agentId: 123)
result.success? # => true
result.attributes[:balance] # => '4200.00'

# Test deposition
result = client.test_deposition(
  agentId: 123,
  dstAccount: 321,
  amount: BigDecimal.new(10.0, 3),
  currency: SoapyYandex::CURRENCY_DEMO_RUBLES,
  contract: 'Test deposit'
)
result.success? # => true

# Make deposition
result = client.make_deposition(
  agentId: 123,
  dstAccount: 321,
  amount: BigDecimal.new(10.0, 3),
  currency: SoapyYandex::CURRENCY_DEMO_RUBLES,
  contract: 'Test deposit'
)
result.success? # => true
```

## Contributing

1. Fork it (https://github.com/ad2games/soapy_yandex/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
