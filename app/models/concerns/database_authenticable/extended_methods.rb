# frozen_string_literal: true

module DatabaseAuthenticable
  ##
  # Module used by models with database authentication
  #
  module ExtendedMethods
    #
    # Virtual attributes
    #

    attr_accessor :password

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
