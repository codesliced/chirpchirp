get '/' do
  erb :index
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)

  user = User.find_or_create_by_oauth_token(:username => @access_token.params[:screen_name],
                           :oauth_token => @access_token.params[:oauth_token],
                           :oauth_secret => @access_token.params[:oauth_token_secret])
  puts user.inspect
  session[:user_id] = user.id
  erb :tweet
  
end

# post '/new/tweet' do
#   twitter_client.update(params[:body])
#   unless request.xhr?
#     erb :tweet
#   end
# end


post '/' do

  tweet = params[:tweet]
  # tweet_obj = Tweet.create(:content => params[:tweet], :published_at => Time.now, :user_id => current_user.id)
  # Twitter.update(tweet_obj.content)
  client = Twitter::Client.new(
    :oauth_token => current_user.oauth_token,
    :oauth_token_secret => current_user.oauth_secret
  )
  puts client.inspect
  client.update(tweet)
  redirect "/"
  # unless request.xhr?
  #   erb :tweet
  # end
  
end