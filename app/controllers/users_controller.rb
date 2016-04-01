class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/'
    end
  end

  get '/users/:id' do
    if logged_in?
      @current_user = current_user
      erb :'users/show'
    else
       erb :'/users/login', locals: {message: "You must be logged in to view this content."}
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/'
    else
      redirect to '/'
    end
  end


  post '/signup' do
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/new', locals: {message: "Oops! Something went wrong. Please fill out all fields to sign up."}
    end
  end

  post '/login' do
    login(params[:username], params[:password])
    if logged_in?      
      redirect to "/users/#{current_user.id}"
    else
      erb :'users/login', locals: {message: "Oops! Please enter a valid username and password to log in."}
    end
  end 



end