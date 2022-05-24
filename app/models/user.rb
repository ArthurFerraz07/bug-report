# frozen_string_literal: true

class User < ApplicationRecord
  #
  # Validations
  #

  validates :name, presence: true
end
