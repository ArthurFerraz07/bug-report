# frozen_string_literal: true

module DatabaseAuthenticable
  ##
  # Module used by models with database authentication
  #
  module ExtendedMethods
    include DatabaseAuthenticable

    #
    # Virtual attributes
    #

    attr_accessor :password

    ##
    # Find user by access token
    #
    def find_by_access_token(access_token)
      payload = parse_access_token(access_token)
      return nil if payload.blank?

      user = User.find_by_uid(payload&.dig(0, 'uid'))
      return nil if user.blank?

      if payload.dig(0, 'access_token').present? && user.tokens.include?(payload.dig(0, 'access_token')) &&
         payload.dig(0, 'easter_egg').present? && DatabaseAuthenticable::JWT_EASTER_EGG.eql?(payload.dig(0, 'easter_egg'))
        user
      end
    rescue StandardError
      nil
    end

    #
    # Extended methods
    #

    def self.extended(klass)
      #
      # Lifecycle
      #

      klass.before_validation :encrypt_password
      klass.before_validation :set_uid
    end
  end
end
