# frozen_string_literal: true

class UrlShortLink < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true

  after_save :set_base62_id_hash

  def set_base62_id_hash
    self.base62_id_hash = Base62.encode(id)
  end
end
