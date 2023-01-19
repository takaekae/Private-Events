
class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :authenticate_user!, only: [:edit, :update, :destroy]

    # detete curent user account


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    super
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      render "edit", notice: 'User was successfully updated.'

    else
      render "edit"
  end
end

  # DELETE /resource
  def destroy
    # deletecurrent user account and all posts
    @user = User.find(current_user.id)
    @user.posts.destroy_all
    if @user.destroy
      render :edit, notice: 'User was successfully deleted.'

    else
      render :edit, notice: 'User was not deleted.'
    end



  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  private



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  # end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end



  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
