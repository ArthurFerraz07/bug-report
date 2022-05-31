# frozen_string_literal: true

module Api
  ##
  # Serialize User's objects
  #
  class UserSerializer < ApplicationSerializer
    #
    # Attributes
    #

    attributes :id, :kind, :username
  end
end
