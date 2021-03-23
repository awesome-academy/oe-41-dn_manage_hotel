module SessionsHelper
  def login user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logined?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    session.delete(:forward_url)
    @current_user = nil
  end

  def store_location
    session[:forward_url] = request.original_url if request.get?
  end

  def redirect_back_or default
    redirect_to(session[:forward_url] || default)
    session.delete(:forward_url)
  end

  def format_date date
    date.strftime("%d/%m/%Y")
  end
end
