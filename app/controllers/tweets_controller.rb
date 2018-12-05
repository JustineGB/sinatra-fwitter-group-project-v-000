class TweetsController < ApplicationController

  get "/tweets" do
    redirect_if_not_logged_in
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

   get "/tweets/new" do
     redirect_if_not_logged_in
    erb :"/tweets/new"
   end

   post "/tweets" do
     redirect_if_not_logged_in
<<<<<<< HEAD
      if params[:content] != ""
=======
      if params[:content] != "" 
>>>>>>> aa53985a4628c20521e4c362a9db33d3d23d25cf
        @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
        flash[:message] = "Tweet successfully created."
        redirect "/tweets/#{@tweet.id}"
      else
        flash[:message] = "Something went wrong."
        redirect '/tweets/new'
      end
    end

   get "/tweets/:id" do
     redirect_if_not_logged_in
     @tweet = Tweet.find(params[:id])
     erb :'/tweets/show_tweet'
   end

   post "/tweets/:id" do
     redirect_if_not_logged_in
     @tweet = Tweet.find(params[:id]) #@tweet.update(params.select{|k|k=="content"})
     @tweet.update(content: params[:content])
     redirect "/tweets/#{@tweet.id}"
   end

  get "/tweets/:id/edit" do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if authorized_to_edit?(@tweet)
      erb :'tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    redirect_if_not_logged_in
    if params[:content] == " " && authorized_to_edit?(@tweet)
      flash[:error] = "You cannot edit someone else's tweet. Please go back to the homepage to edit your own tweet. Also, you cannot post an empty tweet. Please try again with content inside of the textarea before pressing submit."
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    redirect_if_not_logged_in
    @tweet = Tweet.find(params[:id])
    if authorized_to_edit?(@tweet)
      @tweet.destroy
      flash[:message] = "Successfully deleted that Tweet."
      redirect '/'
    else
      flash[:error] = "Error. Did not delete."
      redirect '/tweets'
    end
  end

end
