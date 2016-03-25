class UsersController < ApplicationController

  get '/signup' do
    erb :'users/new'
  end

  get '/login' do
    erb :'users/login'
  end

  get '/users/:id' do
    erb :'users/show'
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
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/users/:id'
    else
      error message and redirect to '/signup'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/users/:id'
    else
      redirect '/login'
    end
  end

  



end