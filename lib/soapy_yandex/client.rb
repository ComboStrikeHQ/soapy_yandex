module SoapyYandex
  class Client
    attr_reader :opts

    def initialize(opts)
      @opts = opts
    end

    protected

    def run(request)
      http_request = HTTParty.post(
        uri_base + request.api_path,
        headers: headers,
        verify_peer: false,
        pem: ssl_cert.to_pem + ssl_key.to_pem,
        body: sign(request.to_s)
      )
      extract_response(http_request.body)
    end

    private

    def extract_response(body)
      message = OpenSSL::PKCS7.new(body)
      unless message.verify([remote_cert], empty_cert_store, nil, OpenSSL::PKCS7::NOVERIFY)
        fail Error.new('Response signature verification failed')
      end

      response = Response.new(message.data)
      raise ServerError.new(response.error_code) if response.error?
      response
    end

    def empty_cert_store
      @empty_cert_store ||= OpenSSL::X509::Store.new
    end

    def remote_cert
      @remote_cert ||= OpenSSL::X509::Certificate.new(opts[:remote_cert])
    end

    def ssl_cert
      @ssl_cert ||= OpenSSL::X509::Certificate.new(opts[:ssl_cert])
    end

    def ssl_key
      @ssl_key ||= OpenSSL::PKey::RSA.new(opts[:ssl_key], opts[:ssl_key_passphrase])
    end

    def sign(payload)
      OpenSSL::PKCS7.sign(ssl_cert, ssl_key, payload, [], OpenSSL::PKCS7::BINARY).to_s
    end

    def headers
      { 'Content-Type' => 'application/pkcs7-mime' }
    end

    def uri_base
      'https://' + opts[:server]
    end
  end
end
