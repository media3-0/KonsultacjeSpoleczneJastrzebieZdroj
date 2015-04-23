class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Dostęp tylko dla administratorów"
      redirect_to root_path
    end
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      return request.env['omniauth.origin']
    else
      redirect = stored_location_for(resource_or_scope)
      return redirect if redirect.present?
    end
    consultations_index_url
  end

end
