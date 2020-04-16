class ApplicationController < ActionController::API

  def current_user
   token = request.headers["Authorization"]
   if token && token.length == 72
     AuthToken.user_from_token(token)
   end
 end
end
