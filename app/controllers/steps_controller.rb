class StepsController < ApplicationController

  get '/steps' do
    if logged_in?
      @steps = Step.all
      erb :"steps/steps"
    else
      redirect to "/login"
    end
  end

  get "/steps/new" do
    if logged_in?
      erb :"steps/new_step"
    else
      redirect to "/login"
    end
  end

  get "/steps/:id" do
    if logged_in?
      @step = Step.find(params[:id])
      erb :"steps/show_step"
    else
      redirect to "/login"
    end
  end

  get "/steps/:id/edit" do
    redirect to "/login" if !logged_in? 
    @step = Step.find(params[:id])
    if @step && (@step.user_id == current_user.id)
      erb :"steps/edit_step"
    else
      redirect to "/login"
    end
  end
  

  post "/steps" do
    redirect to "/steps/new_step" if params["content"].empty?
    @step = Step.new(content: params["content"], user_id:current_user.id)
    @step.save
    redirect to "/steps/#{@step.id}"
  end

  patch "/steps/:id" do
    redirect to "/steps/#{params[:id]}/edit" if params["content"].empty?
    @step = Step.find(params[:id])
    if @step && (@step.user_id == current_user.id)
      @step.update(content: params["content"])
      @step.save
      redirect to "/steps/#{@step.id}"
    end
  end

  delete "/steps/:id/delete" do
    redirect to "/login" if !logged_in? 
    @step = Step.find(params[:id])
    if @step && (@step.user_id == current_user.id)
      @step.delete
      redirect to '/steps'
    else
      redirect to "/login"
    end
  end




end
