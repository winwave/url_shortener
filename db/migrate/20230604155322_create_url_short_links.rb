# frozen_string_literal: true

class CreateUrlShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :url_short_links do |t|
      t.string :original_url, null: false
      t.string :base62_id_hash

      t.index ['base62_id_hash'], name: 'index_photos_on_base62_id_hash'
      t.index ['original_url'], name: 'index_photos_on_original_url'
      t.timestamps
    end
  end
end
