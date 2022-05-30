# frozen_string_literal: true

module Api
  ##
  # Serialize ApplicationError's objects
  #
  class ErrorSerializer < ApplicationSerializer
    #
    # Attributes
    #

    attributes :id, :message
  end
end
