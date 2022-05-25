# frozen_string_literal: true

##
# User
#
class User < ApplicationRecord
  extend DatabaseAuthenticable::ExtendedMethods
  include DatabaseAuthenticable::IncludedMethods

  #
  # Enums
  #

  enum kind: %i[maintainer developer customer]

  #
  # Validations
  #

  validates :name, :uid, :username, :encrypted_password, :kind, presence: true, allow_blank: false
end
