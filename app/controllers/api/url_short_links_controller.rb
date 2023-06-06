# frozen_string_literal: true

module Api
  class UrlShortLinksController < ApplicationController
    skip_before_action :authenticate_request, only: :show

    def create
      item = UrlShortLink.find_or_create_by(original_url: url_short_link_params[:original_url])
      if item.save!
        render json: { url_shortener: "#{request.base_url}/#{item.base62_id_hash}" }, status: :created
      else
        render json: item.errors, status: :unprocessable_entity
      end
    end

    def show
      item = UrlShortLink.find_by(base62_id_hash: params[:shorten_id])

      if item.present?
        redirect_to item.original_url, allow_other_host: true
      else
        render json: { message: 'Not found' }, status: :not_found
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def url_short_link_params
      params.fetch(:url_short_link, {}).permit([:original_url])
    end
  end
end
