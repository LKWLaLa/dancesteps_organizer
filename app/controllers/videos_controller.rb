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
    redirect to "/videos/new_video" if params["content"].empty?
    @video = Video.new(content: params["content"], user_id:current_user.id)
    @video.save
    redirect to "/videos/#{@video.id}"
  end


  patch "/videos/:id" do
    redirect to "/videos/#{params[:id]}/edit" if params["content"].empty?
    @video = Video.find(params[:id])
    if @video && (@video.user_id == current_user.id)
      @video.update(content: params["content"])
      @video.save
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