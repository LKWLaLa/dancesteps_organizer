class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/users/:id' do
    if logged_in?
      erb :'users/show'
    else
      erb :'/users/new', locals: {message: "Oops! You must be logged in to view this page."}
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end


  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/users/:id'
    else
      erb :'/users/new', locals: {message: "Oops! Something went wrong. Please enter a username and password to sign up."}
    end
  end

  post '/login' do
    login(params[:username], params[:password])
    if logged_in?
      redirect '/users/:id'
    else
      erb :'users/login', locals: {message: "Please enter a valid username and password to log in."}
    end
  end

  



end