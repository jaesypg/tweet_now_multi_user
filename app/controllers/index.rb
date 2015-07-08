get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/' do
  # @username = params[:username]
  # @username = "jaesy69"
  @username = session[:username]
  @twitteruser = TwitterUser.find_by_username(@username)
  @tweet = params[:tweet][:text]

  # $client.update(@tweet)
  @twitteruser.tweet!(@tweet)

  # redirect to "/#{@username}"
  if @twitteruser.tweets_stale?
    # @twitteruser.fetch_tweets!(@twitteruser.username)
    @twitteruser.fetch_tweets!
  end
  @tweets = @twitteruser.tweets.limit(10)
  erb :tweets, layout: false
end

# get '/:username' do
#   @username = params[:username]
#   @twitteruser = TwitterUser.find_by_username(@username)
#   if @twitteruser
#     # @twitteruser.fetch_tweets!(@twitteruser.username)
#     @twitteruser.fetch_tweets!
#   end
#   @tweets = @twitteruser.tweets.limit(10)
#   erb :index
# end

get '/:username' do
  @username = params[:username]
  @twitteruser = TwitterUser.find_by_username(@username)
  if @twitteruser.tweets_stale?
    # @twitteruser.fetch_tweets!(@twitteruser.username)
    @twitteruser.fetch_tweets!
  end
  @tweets = @twitteruser.tweets.limit(10)
  erb :tweets, layout: false
end

# use omniauth twitter
# http://www.sitepoint.com/twitter-authentication-in-sinatra/
post '/signin/twitter' do
  redirect to '/auth/twitter'
end

get '/auth/twitter/callback' do
  @username =  env['omniauth.auth']['info'].nickname
  token     =  env['omniauth.auth']['credentials'].token
  secret    =  env['omniauth.auth']['credentials'].secret
  @twitteruser = TwitterUser.find_by_username(@username)
  if @twitteruser == nil
    @twitteruser = TwitterUser.create(username: @username, access_token_id: token, access_token_secret_key_id: secret)
  else
    @twitteruser.access_token_id = token
    @twitteruser.access_token_secret_key_id = secret
    @twitteruser.save
  end
  session[:username] = @twitteruser.username
  redirect to "/"
end

post '/logout' do
  session[:username] = nil
  redirect to '/'
end


