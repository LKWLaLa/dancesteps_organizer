class VideosController < ApplicationController

  get '/videos' do
    if logged_in?
      @videos = current_user.videos
      erb :"videos/videos"
    else
      redirect to "/login"
    end
  end

  get "/videos/new" do
    if logged_in?
      erb :"videos/new_video"
    else
      redirect to "/login"
    end
  end

  get "/videos/:id" do
    redirect to "/login" if !logged_in? 
    @video = Video.find_by_id(params[:id])
    if @video && (@video.user_id == current_user.id)
      erb :"videos/show_video"
    else 
      erb :index, locals: {message: "You must be the video owner in order to access."}  
    end  
  end


  get "/videos/:id/edit" do
    redirect to "/login" if !logged_in? 
    @video = Video.find_by_id(params[:id])
    if @video && (@video.user_id == current_user.id)
      erb :"videos/edit_video"
    else
      erb :"index", locals: {message: "You must be the video owner in order to access."}  
    end
  end
  

  post "/videos" do
    if !params[:video][:title].empty? && !params[:video][:url].empty?
      @video = Video.new(params[:video]) 
      @video.user_id = current_user.id
    
      if !params[:step][:name].empty?
        @step = Step.new(params[:step])
        @step.user_id = current_user.id
        @video.steps << @step
      end 
      @video.save
      redirect to "/videos/#{@video.id}"
    else 
      erb :"videos/new_video", locals: {message: "A new video must contain both a title and url."}  
    end
  end


  patch "/videos/:id" do
    @video = Video.find(params[:id])
    if @video && (@video.user_id == current_user.id)
      if !params[:video][:title].empty? && !params[:video][:url].empty?
        params[:video][:step_ids] ||= []
        @video.update(params[:video])
     
        if !params[:step][:name].empty?
          @step = Step.new(params[:step])
          @step.user_id = current_user.id
          @video.steps << @step
          @video.save
        end
          redirect to "/videos/#{@video.id}"  
      else
        erb :"videos/edit_video", locals: {message: "A video must contain both a title and url."} 
      end 
    end
  end
  

  delete "/videos/:id/delete" do
    redirect to "/login" if !logged_in? 
    @video = Video.find_by_id(params[:id])
    if @video && (@video.user_id == current_user.id)
      @video.delete
      redirect to '/videos'
    else
      erb :"index", locals: {message: "You do not have permission to delete this video."}
    end
  end

end



