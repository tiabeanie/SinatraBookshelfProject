require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ilovebooks"
  end


  get '/' do 
    erb :index
  end

  helpers do
    def redirect_to_login
      if !logged_in?
        redirect "/login?error=You have to be logged in for that"
      end
    end

    def redirect_if_not_authorized(owner, path)
      if owner != current_user
        redirect path
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end