require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user      #!!session[:user_id]
    end

    def current_user
<<<<<<< HEAD
      #User.find(session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
=======
      User.find(session[:user_id])
>>>>>>> aa53985a4628c20521e4c362a9db33d3d23d25cf
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be loggin in to view that page."
        redirect "/login"
      end
    end

    def authorized_to_edit?(tweet)
      @tweet.user == current_user
    end
  end

end
