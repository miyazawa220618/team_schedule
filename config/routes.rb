Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

end
