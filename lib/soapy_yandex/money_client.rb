module SoapyYandex
  class MoneyClient < Client
    def test_deposition(args)
      format_amount(args)

      run Request.new(
        '/webservice/deposition/api/testDeposition',
        'testDepositionRequest',
        args
      )
    end

    def make_deposition(args)
      format_amount(args)

      run Request.new(
        '/webservice/deposition/api/makeDeposition',
        'makeDepositionRequest',
        args
      )
    end

    def balance(args)
      run Request.new(
        '/webservice/deposition/api/balance',
        'balanceRequest',
        args
      )
    end

    private

    def format_amount(args)
      raise 'Amount must be a BigDecimal' unless args[:amount].is_a?(BigDecimal)
      args[:amount] = '%0.2f' % args[:amount]
    end
  end
end
