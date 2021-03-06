class Api::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :require_no_authentication

  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      resource.ensure_authentication_token!
      sign_in resource
      render json: {auth_token: resource.authentication_token, user: resource}, status: :created
      return
    end
    invalid_login_attempt
  end

  def show
    resource = current_user
    if resource
      render json: {auth_token: resource.authentication_token, user: resource}, status: :ok
    else
      render json: {}, status: 401
    end
  end

  def destroy
    resource = current_user
    if resource
      resource.authentication_token = nil
      resource.save
      sign_out resource
      render :json=> {}, status: 204
    else
      render json: {}, status: 401
    end
  end

  protected

  def invalid_login_attempt
    render :json=> {:message=>"Error with your login or password"}, status: 401
  end
end
