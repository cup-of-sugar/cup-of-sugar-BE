class ApplicationController < ActionController::API

  def current_user
   token = request.headers["Authorization"]
   token.length > 2 ? AuthToken.user_from_token(token) : return
 end
end
