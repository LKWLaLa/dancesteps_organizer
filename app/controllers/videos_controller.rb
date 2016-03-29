require 'pry'

class VideosController < ApplicationController

  get '/videos' do
    if logged_in?
      @videos = Video.all
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
    if logged_in?
      @video = Video.find(params[:id])
      erb :"videos/show_video"
    else
      redirect to "/login"
    end
  end

  get "/videos/:id/edit" do
    redirect to "/login" if !logged_in? 
    @video = Video.find(params[:id])
    if @video && (@video.user_id == current_user.id)
      erb :"videos/edit_video"
    else
      redirect to "/login"
    end
  end
  

  post "/videos" do
    redirect to "/videos/new_video" if params[:video].empty?
    @video = Video.new(params[:video]) 
    @video.user_id = current_user.id
    @video.save
    @step = Step.new(params[:step])
    @step.user_id = current_user.id
    if @step.save
      @step.videos << @video
    end
    redirect to "/videos/#{@video.id}"
  end


  patch "/videos/:id" do
    binding.pry
    @video = Video.find(params[:id])
    if @video && (@video.user_id == current_user.id)
      binding.pry
      @video.update(params[:video])

      if params[:step][:name] != "" 
        @step = Step.new(params[:step])
        @step.user_id = current_user.id
        if @step.save
          @video.steps << @step
        end     
      end
      redirect to "/videos/#{@video.id}"
    end
  end
  

  delete "/videos/:id/delete" do
    redirect to "/login" if !logged_in? 
    @video = Video.find(params[:id])
    if @video && (@video.user_id == current_user.id)
      @video.delete
      redirect to '/videos'
    else
      redirect to "/login"
    end
  end

end