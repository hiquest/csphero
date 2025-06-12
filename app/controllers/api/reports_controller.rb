class Api::ReportsController < ApplicationController

  before_action :authenticate_user!

  def aggs
    website_id = params[:website_id]

    if website_id.blank?
      render json: { error: "website_id is required" }, status: 400
      return
    end

    ws = current_user.websites.find_by(id: website_id)

    if ws.blank?
      render json: { error: "website not found" }, status: 404
      return
    end
    
    range = params[:range] || '24h'

    aggs = AggregatedReport.all(ws, range)

    render json: aggs.map(&:go_json)
  end

  def index
    website_id = params[:website_id]

    if website_id.blank?
      render json: { error: "website_id is required" }, status: 400
      return
    end

    ws = current_user.websites.find_by(id: website_id)

    if ws.blank?
      render json: { error: "website not found" }, status: 404
      return
    end

    page = if params[:page].present?
             params[:page].to_i
           else
             0
           end

    reports = Report.filter(ws, {
      range: params[:range],
      violated_directive: params[:violated_directive],
      disposition: params[:disposition],
      blocked_uri: params[:blocked_uri],
      source_file: params[:source_file],
      page: page,
      filter_extensions: params[:filter_extensions] == '1',
    })

    render json: reports.map(&:go_json)
  end

  def time_series
    website_id = params[:website_id]

    if website_id.blank?
      render json: { error: "website_id is required" }, status: 400
      return
    end

    ws = current_user.websites.find_by(id: website_id)

    if ws.blank?
      render json: { error: "website not found" }, status: 404
      return
    end

    aggs = Report.time_series(ws, {
      range: params[:range],
      violated_directive: params[:violated_directive],
      disposition: params[:disposition],
      blocked_uri: params[:blocked_uri],
      source_file: params[:source_file],
      filter_extensions: params[:filter_extensions] == '1',
    })

    render json: aggs
  end

end
