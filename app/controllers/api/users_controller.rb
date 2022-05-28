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
      if user&.valid_password?(authenticate_params[:password])
        success(UserSerializer, user)
      else
        unauthorized
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
