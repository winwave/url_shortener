# frozen_string_literal: true

FactoryBot.define do
  factory :url_short_link do
    original_url { 'http://www.original_url.com' }
    base62_id_hash { 'shortenHash' }
  end
end
