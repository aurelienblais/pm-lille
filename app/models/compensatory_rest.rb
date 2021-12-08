# frozen_string_literal: true

class CompensatoryRest < ApplicationRecord
  paginates_per 10

  belongs_to :agent

  default_scope -> { order(created_at: :desc) }
end
