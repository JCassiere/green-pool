class TwilioController < ApplicationController
	skip_before_action :verify_authenticity_token

	def send_sms
    client = Twilio::REST::Client.new(
    	Rails.application.secrets.twilio_account_sid,
    	Rails.application.secrets.twilio_auth_token
    )
    params[:sms_numbers].each do
	    client.messages.create(
	      to: "513-703-4852",
	      from: Rails.application.secrets.twilio_phone_number,
	      body: params[:body]
	    )
	  end
	  redirect_to params[:final_path]
  end
end
