class Api::UsersController < ApplicationController

  before_action :authenticate_user!

  def me
    render json: current_user.go_json
  end

end
