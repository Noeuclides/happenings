class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  # protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token

  def respond_with(current_user, _opts = {})
    debugger
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end