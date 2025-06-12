class AppController < ApplicationController
  def index
    if !current_user
      redirect_to new_user_session_path
    end
  end

  def terms
  end
end
