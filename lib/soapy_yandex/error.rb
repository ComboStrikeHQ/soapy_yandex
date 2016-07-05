# frozen_string_literal: true
module SoapyYandex
  class Error < ::RuntimeError
  end

  class ServerError < Error
    ERROR_MESSAGES = {
      10 => 'XML parse error',
      11 => 'Invalid agendId',
      12 => 'Invalid subAgentId',
      14 => 'Invalid currency',
      15 => 'Invalid requestDT',
      16 => 'Invalid dstAccount',
      17 => 'Invalid amount',
      18 => 'Invalid clientOrderId',
      19 => 'Invalid contract',
      21 => 'Operation not available',
      26 => 'There was already a transaction with this clientOrderId',
      50 => 'Unable to read signed message',
      51 => 'Signature verification failed',
      53 => 'Signed by unknown certificate',
      40 => 'User account closed',
      41 => 'User account blocked',
      42 => 'Payee identifier does not exist',
      43 => 'Amount too big',
      44 => 'Too many transactions in timeframe',
      45 => 'Not enough funds',
      46 => 'Amount too small'
    }.freeze

    attr_reader :error_code

    def initialize(error_code)
      @error_code = error_code
    end

    def message
      ERROR_MESSAGES.fetch(error_code, 'Unknown error')
    end
  end
end
