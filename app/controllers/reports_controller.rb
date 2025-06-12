class ReportsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    website = Website.find_by(token: params[:token])
    if website.nil?
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
      return
    end

    raw_headers = request.headers.env.select { |k, _v| k.start_with?('HTTP_') }
    raw_json_body = request.body.read

    report = website.reports.create!(
      raw_headers: raw_headers,
      raw_body: raw_json_body
    )

    report.parse!

    render json: { message: 'Report created' }, status: :created
  end
end
