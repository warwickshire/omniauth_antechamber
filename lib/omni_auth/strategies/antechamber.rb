require 'omniauth/strategies/oauth2'
require 'omniauth_antechamber'

module OmniAuth
  module Strategies
    class Antechamber < OmniAuth::Strategies::OAuth2

      def self.auth_url(path = nil)
        return auth_provider_url unless path
        File.join(auth_provider_url, path)
      end

      def self.auth_provider_url
        AUTH_PROVIDER_URL || '/'
      end

      option :name, "antechamber"

      option :client_options, {
        site:             auth_url,
        authorize_url:    auth_url('auth/authorize'),
        access_token_url: auth_url('auth/access_token'),
        token_url:        auth_url('oauth/token'),
        ssl:              {verify: false} # This is a hack to fix issues verifying the ssl certificate: https://github.com/intridea/oauth2/issues/12
      }

      def verify_token(id_token, access_token)
        id_token && access_token
      end

      uid do
        raw_info['id']
      end

      info do
        {
          :email => raw_info['email']
        }
      end

      extra do
        raw_info['extra']
      end

      def raw_info
        @raw_info ||= get_access_token
      end

      def auth_url(path = nil)
        self.class.auth_url path
      end

      def get_access_token
        access_token.get(access_token_request_uri).parsed
      end

      def access_token_request_uri
        uri = URI(auth_url('auth/user'))
        uri.query = {oauth_token: access_token.token}.to_query
        uri.to_s
      end

      def authority_data
        @authority_data ||= raw_info['authority'] || {}
      end

    end
  end
end
