# frozen_string_literal: true

##
# Users controller
#
class UsersController < ApplicationController
  ##
  # Login page
  #
  def login
    render 'users/login'
  end
end
