# frozen_string_literal: true

##
# Pages controller
#
class PagesController < ApplicationController
  ##
  # Main page
  #
  def main
    render 'pages/main'
  end
end
