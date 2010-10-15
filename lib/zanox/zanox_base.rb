require 'hmac-sha1'
require 'base64' 

module Zanox
  
  class ZanoxBase
    
    attr_accessor :timestamp
    attr_reader :application_id, :last_error_msg
    attr_writer :version
    
    def initialize(version = false)
      @version = version
      @connect_id = ''
      @private_key = ''
      @timestamp = false
      @version = false
      @api_security = false
      @last_error_msg = false
    end
    
    def set_message_credentials(connect_id, private_key)
      @connect_id = connect_id
      @private_key = private_key
    end

    def get_errors(foo=0)
      return @last_error_msg
    end

    protected

    def get_hmac_signature(mesgparams)
      hmac = Base64.encode64(HMAC::SHA1.digest(@private_key,mesgparams)).chomp
      hmac
    end

    def enable_api_security
      @api_security = true
    end

    def disable_api_security
      @api_security = false
    end

    def get_timestamp

    end
    
    def get_nonce(time = Time.now)
      t = time.to_i
      hashed = [t, @secret_key]
      digest = ::Digest::MD5.hexdigest(hashed.join(":"))
      Base64.encode64("#{t}:#{digest}").gsub("\n", '')
    end
    
  end
  
end
