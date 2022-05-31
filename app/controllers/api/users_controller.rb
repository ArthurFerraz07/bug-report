# frozen_string_literal: true

module Api
  ##
  # Users controller
  #
  class UsersController < ApiController
    skip_before_action :authenticate_user!, only: %i[authenticate]

    ##
    # Authenticate user
    #
    def authenticate
      user = User.find_by(uid: authenticate_params[:uid])
      if user&.valid_password?(authenticate_params[:password]) && user&.authenticate
        @current_access_token = user.current_access_token
        success(UserSerializer, user)
      else
        unauthorized('Invalid credentials')
      end
    end

    ##
    # Logout user
    #
    def logout
      raw_token = parse_access_token(current_access_token).dig(0, 'access_token')
      current_user.tokens.delete(raw_token) if raw_token.present?
      if current_user.save
        success(UserSerializer, current_user)
      else
        bad_request
      end
    end

    private

    ##
    # Permitted params for authenticate
    #
    def authenticate_params
      params.permit(:uid, :password)
    end
  end
end
