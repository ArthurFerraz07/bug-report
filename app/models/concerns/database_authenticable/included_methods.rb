# frozen_string_literal: true

require 'securerandom'

module DatabaseAuthenticable
  ##
  # Module used by models with database authentication
  #
  module IncludedMethods
    #
    # Constants
    #

    TOKEN_EXP = 8

    #
    # Virtual attributes
    #

    attr_accessor :current_access_token, :password

    ##
    # Generate auth tokens
    #
    def generate_access_token
      token_ = nil
      loop do
        token_ = SecureRandom.hex(2**TOKEN_EXP)

        break if self.class.where(':token = ANY(tokens)', token: token_).blank?
      end
      self.tokens ||= []
      tokens << token_
      self
    end

    ##
    # Login resource
    #
    def login
      generate_access_token
      payload = { uid:, access_token: tokens.last, easter_egg: DatabaseAuthenticable::JWT_EASTER_EGG }
      self.current_access_token = JWT.encode(payload, DatabaseAuthenticable::JWT_HS512_KEY, 'HS512')
      save
    end

    ##
    # Check if passed password is valid for user
    #
    def valid_password?(password_)
      return false if [password_, encrypt_password].any?(&:blank?)

      Argon2::Password.verify_password(password_, encrypted_password, ENV['PASSWORD_HASHER_KEY'])
    end

    private

    ##
    # Encrypt password using Argon2 algorithm
    #
    def encrypt_password
      return self if password.nil?

      self.encrypted_password = DatabaseAuthenticable::PASSWORD_HASHER.create(password)
      self
    end

    ##
    # Set user uid
    #
    def set_uid
      self.uid = username&.downcase
      self
    end
  end
end
