# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlShortLink, type: :model do
  subject { described_class.new }
  describe 'Validations' do
    context 'with original_url already exist' do
      before do
        FactoryBot.create(:url_short_link)
      end
      it 'should not be valid with unique validation' do
        subject.original_url = 'http://www.original_url.com'

        expect(subject).not_to be_valid
      end
    end

    context 'with original_url nil' do
      before do
        FactoryBot.create(:url_short_link)
      end
      it 'should not be valid with nil validation' do
        subject.original_url = nil

        expect(subject).not_to be_valid
      end
    end
  end

  describe 'methods' do
    it 'should generate base62 hash' do
      subject.id = 10
      subject.original_url = 'http://www.original_url.com'
      subject.save!

      expect(subject.base62_id_hash).to eq('a')
    end
  end
end
