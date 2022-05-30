# frozen_string_literal: true

module Api
  ##
  # API controller
  #
  class ApiController < ApplicationController
    skip_forgery_protection
    before_action :authenticate_user!
    after_action :set_auth_headers

    #
    # Virtual attributes
    #

    attr_accessor :current_user
    attr_reader :current_access_token

    private

    ##
    # Check if user is authenticated
    #
    def authenticate_user!
      @current_access_token = request.headers['HTTP_ACCESS_TOKEN']
      @current_user = User.find_by_access_token(current_access_token)
      return unauthorized if @current_user.blank?
    end

    ##
    # Bad request response
    #
    def bad_request(messages = [], status: :bad_request)
      errors = messages.map { |message| ApplicationError.new(status, message) }
      render(json: serialize_collection(ErrorSerializer, errors), status:)
    end

    ##
    # Serialize collection
    #
    def serialize_collection(serializer, collection)
      return nil if collection.nil?

      collection.map { |object| serialize_object(serializer, object) }
    end

    ##
    # Serialize object
    #
    def serialize_object(serializer, object)
      return nil if object.nil?

      serializer.new(object).serializable_hash.dig(:data, :attributes)
    end

    ##
    # Set auth headers
    #
    def set_auth_headers
      response.headers['access_token'] = current_access_token
    end

    ##
    # Success response
    #
    def success(serializer, object)
      render(json: serialize_object(serializer, object), status: :ok)
    end

    ##
    # Unauthorized response
    #
    def unauthorized(message = 'Unauthenticated')
      bad_request([message], status: :unauthorized)
    end
  end
end
