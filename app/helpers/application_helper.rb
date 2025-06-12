module ApplicationHelper

  # all the data client needs to work with
  def js_data
    {
      env: Rails.env,
      flash: flash.present? ? flash.to_hash : nil,
    }
  end

end
