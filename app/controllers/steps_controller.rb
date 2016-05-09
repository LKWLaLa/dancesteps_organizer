class StepsController < ApplicationController

  get '/steps' do
    if logged_in?
      @steps = current_user.steps
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
    redirect to "/login" if !logged_in? 
    @step = current_user.steps.find_by(id: params[:id])
    if @step
      erb :"steps/show_step"
    else
     erb :index, locals: {message: "You must be the step owner in order to access."}  
    end
  end

  get "/steps/:id/edit" do
    redirect to "/login" if !logged_in? 
    @step = current_user.steps.find_by(id: params[:id])
    if @step
      erb :"steps/edit_step"
    else
      erb :"index", locals: {message: "You must be the step owner in order to access."}  
    end
  end
  

  post "/steps" do
    if step_has_name?
      @step = Step.new(params[:step]) 
      @step.user_id = current_user.id
     
      if video_has_title_and_url?
        @video = Video.new(params[:video])
        @video.user_id = current_user.id
        @step.videos << @video
      end
      @step.save
      redirect to "/steps/#{@step.id}"
    else
      erb :"steps/new_step", locals: {message: "A new step must have a name."}  
    end
  end

  patch "/steps/:id" do
    @step = current_user.steps.find_by(id: params[:id])
    if @step
      if step_has_name?
        params[:step][:video_ids] ||= []
        @step.update(params[:step])

        if video_has_title_and_url?
          @video = Video.new(params[:video])
          @video.user_id = current_user.id
          @step.videos << @video
          @step.save
        end  
          redirect to "/steps/#{@step.id}"   
      else
        erb :"steps/edit_step", locals: {message: "A step must have a name."} 
      end
    end
  end

  delete "/steps/:id/delete" do
    redirect to "/login" if !logged_in? 
    @step = current_user.steps.find_by(id: params[:id])
    if @step && @step.delete
      redirect to '/steps'
    else
      erb :"index", locals: {message: "You do not have permission to delete this step."}
    end
  end

end




