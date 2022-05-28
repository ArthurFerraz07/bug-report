# frozen_string_literal: true

module Api
  ##
  # API controller
  #
  class ApiController < ApplicationController
    skip_forgery_protection
    before_action :authenticate_user!

    #
    # Virtual attributes
    #

    attr_accessor :current_user

    private

    ##
    # Check if user is authenticated
    #
    def authenticate_user!
      token = request.headers['token']
      @current_user = User.authenticate_by_token(token)
      return unauthorized if @current_user.blank?
    end

    ##
    # Bad request response
    #
    def bad_request(messages = [], status: :bad_request)
      messages = messages.map { |message| StandardError.new(message) }
      render(json: ErrorSerializer.new(messages).serialized_json, status:)
    end

    ##
    # Success response
    #
    def success(serializer, object)
      render(json: serializer.new(object).serialized_json)
    end

    ##
    # Unauthorized response
    #
    def unauthorized
      bad_request(['Unauthenticated'], status: :unauthorized)
    end
  end
end
