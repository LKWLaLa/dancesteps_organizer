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
    redirect to "/steps/new_step" if params[:step].empty?
    @step = Step.new(params[:step]) 
    @step.user_id = current_user.id
    @step.save
    @video = Video.new(params[:video])
    @video.user_id = current_user.id
    if @video.save
      @video.steps << @step
      @video.save
    end
    redirect to "/steps/#{@step.id}"
  end

  patch "/steps/:id" do
    @step = Step.find(params[:id])
    if @step && (@step.user_id == current_user.id)
      @step.update(params[:step])
      @step.save

      if !params[:video].empty?
        @video = Video.new(params[:video])
        @video.user_id = current_user.id
        if @video.save
          @video.steps << @step 
          @video.save
        end     
      end
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
