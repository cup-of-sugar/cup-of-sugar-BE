class ApplicationController < ActionController::API

  def current_user
   token = request.headers["Authorization"]
   AuthToken.user_from_token(token)
 end
end
