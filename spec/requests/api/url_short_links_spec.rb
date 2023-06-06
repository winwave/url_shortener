# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/api/shorten', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'POST /shorten' do
    context 'with authorized user' do
      before do
        allow(AuthorizeApiRequest).to receive_message_chain(:call, :result).and_return(user)
      end

      it 'renders a successful response' do
        post api_shorten_path, params: { url_short_link: { original_url: 'url' } }, as: :json
        expect(response).to be_successful
      end

      it 'renders a shorten url response' do
        post api_shorten_path, params: { url_short_link: { original_url: 'url' } }, as: :json
        expect(body_as_json).to match({ 'url_shortener' => %r{http://www.example.com/} })
      end
    end

    context 'with unauthorized user' do
      it 'raise unauthorized error' do
        post api_shorten_path, params: { url_short_link: { original_url: 'url' } }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /{shorten}' do
    context 'without shorten url exists' do
      it 'renders not found message' do
        get '/shortenHash', as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
    context 'with a shorten url exists' do
      before do
        FactoryBot.create(:url_short_link)
      end

      it 'redirect to original link' do
        get '/shortenHash', as: :json
        expect(response).to redirect_to('http://www.original_url.com')
      end
    end
  end
end
