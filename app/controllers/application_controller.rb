class ApplicationController < ActionController::Base
   helper_method :current_user

   def current_user
     # underscore at the start of @current_user indicates that this instance variable is not part of the public API of the class
     @_current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

   def current_admin?
      current_user && current_user.admin?
   end

   private
   def error_message(errors)
      errors.full_messages.join(', ')
   end
end
