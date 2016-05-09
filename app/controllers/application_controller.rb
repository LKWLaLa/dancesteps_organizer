require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "swivels"
  end

  get "/" do
    erb :"index"
  end

  helpers do

    def login(username, password)
      user = User.find_by(username: username) 
      if user && user.authenticate(password)
        session[:user_id] = user.id
      end
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def step_has_name?
      params[:step][:name].present?
    end

    def video_has_title_and_url?
      params[:video][:title].present? && params[:video][:url].present?
    end

  end
 

end














