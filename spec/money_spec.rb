RSpec.describe 'Yandex Money Requests', :vcr do
  around { |example| Timecop.freeze(Time.utc(2015, 01, 19), &example) }

  let(:client) do
    if ENV['USE_REAL_CERTS']
      cert_file = '../../cert.pem'
      key_file = '../../key.pem'
    else
      cert_file = '../fixtures/keys/fake_cert.pem'
      key_file = '../fixtures/keys/fake_key.pem'
    end

    SoapyYandex::MoneyClient.new(
      ssl_cert: File.read(File.expand_path(cert_file,  __FILE__)),
      ssl_key: File.read(File.expand_path(key_file, __FILE__)),
      remote_cert: File.read(File.expand_path('../fixtures/keys/remote_cert.pem', __FILE__)),
      ssl_key_passphrase: ENV['PASSPHRASE'],
    )
  end

  before :each do
    intercept(OpenSSL::PKCS7, :sign) do  |method, cert, key, payload, *args|
      hash = Digest::SHA256.hexdigest(payload)
      file = "spec/fixtures/ssl/#{hash}"
      next File.read(file) if File.exists?(file)

      result = method.call(cert, key, payload, *args)
      File.open(file, 'w+') { |f| f.write(result) }
      result
    end

    allow(SecureRandom).to receive(:hex) do
      $random ||= 0
      $random += 1
    end
  end

  describe '#test_deposition' do
    it 'returns successfully' do
      result = client.test_deposition(
        agentId: 200451,
        clientOrderId: 12345,
        dstAccount: 4100322650604,
        amount: BigDecimal.new(10.0,  3),
        currency: 10643,
        contract: 'Test deposit'
      )

      expect(result.success?).to be_truthy
      expect(result.attributes[:clientOrderId]).to eq('12345')
    end
  end

  describe '#make_deposition' do
    it 'returns successfully' do
      result = client.make_deposition(
        agentId: 200451,
        clientOrderId: 12345,
        dstAccount: 4100322650604,
        amount: BigDecimal.new(10.0,  3),
        currency: 10643,
        contract: 'Test deposit'
      )

      expect(result.success?).to be_truthy
      expect(result.attributes[:clientOrderId]).to eq('12345')
    end
  end

  describe '#balance' do
    it 'returns the balance amount' do
      result = client.balance(agentId: 200451)

      expect(result.success?).to be_truthy
      expect(result.attributes[:balance]).to eq('-10.00')
    end
  end
end
