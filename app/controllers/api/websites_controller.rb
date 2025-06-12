class Api::WebsitesController < ApplicationController

  before_action :authenticate_user!

  def index
    company = current_user.companies.first
    websites = company.websites.order(created_at: :desc)
    render json: websites.map(&:go_json)
  end

  def show
    company = current_user.companies.first
    website = company.websites.find_by(id: params[:id])
    render json: website.go_json
  end

  def create
    company = current_user.companies.first

    d = params[:domain]
    if d.end_with?('/')
      d = d[0..-2]
    end

    puts d

    website = company.websites.create(domain: d)

    if website.errors.any?
      render json: { errors: website.errors.full_messages }, status: 422
      return
    end

    render json: website.go_json
  end

end
