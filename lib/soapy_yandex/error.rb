module SoapyYandex
  class Error < ::RuntimeError
  end

  class ServerError < Error
    attr_reader :error_code

    def initialize(error_code)
      @error_code = error_code
    end

    def error_code_string
      case error_code
      when 10 then 'XML parse error'
      when 11 then 'Invalid agendId'
      when 12 then 'Invalid subAgentId'
      when 14 then 'Invalid currency'
      when 15 then 'Invalid requestDT'
      when 16 then 'Invalid dstAccount'
      when 17 then 'Invalid amount'
      when 18 then 'Invalid clientOrderId'
      when 19 then 'Invalid contract'
      when 21 then 'Operation not available'
      when 26 then 'There was already a transaction with this clientOrderId'
      when 50 then 'Unable to read signed message'
      when 51 then 'Signature verification failed'
      when 53 then 'Signed by unknown certificate'
      when 40 then 'User account closed'
      when 41 then 'User account blocked'
      when 42 then 'Payee identifier does not exist'
      when 43 then 'Amount too big'
      when 44 then 'Too many transactions in timeframe'
      when 45 then 'Not enough funds'
      when 46 then 'Amount too small'
      else 'Unknown error'
      end
    end

    def to_s
      "SoapyYandex Server Error: #{error_code_string}"
    end
  end
end
