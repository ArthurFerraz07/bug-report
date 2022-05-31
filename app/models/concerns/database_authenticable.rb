# frozen_string_literal: true

##
# Module used by models with database authentication
#
module DatabaseAuthenticable
  extend ActiveSupport::Concern

  #
  # Constants
  #

  PASSWORD_HASHER_KEY = ENV['PASSWORD_HASHER_KEY']
  PASSWORD_HASHER = Argon2::Password.new(t_cost: 2, m_cost: 16, secret: PASSWORD_HASHER_KEY)
  JWT_EASTER_EGG = ENV['JWT_EASTER_EGG']
  JWT_HS512_KEY = ENV['JWT_HS512_KEY']

  ##
  # Parse access token
  #
  def parse_access_token(access_token)
    JWT.decode(access_token, JWT_HS512_KEY, true, { algorithm: 'HS512' })
  end
end
