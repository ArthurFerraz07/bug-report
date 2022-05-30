# frozen_strin_literal: true

##
#
#
class ApplicationError < StandardError
  #
  # Virtual attributes
  #

  attr_accessor :id

  ##
  # Initialize an application error
  #
  def initialize(id, message = nil)
    @id = id
    super(message)
  end
end
