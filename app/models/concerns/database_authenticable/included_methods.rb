# frozen_string_literal: true

module DatabaseAuthenticable
  ##
  # Module used by models with database authentication
  #
  module IncludedMethods
    #
    # Virtual attributes
    #

    attr_accessor :password

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
