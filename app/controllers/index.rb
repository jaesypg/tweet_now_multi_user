get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/' do
  # @username = params[:username]
  @username = "jaesy69"
  @twitteruser = TwitterUser.find_by_username(@username)
  @tweet = params[:tweet][:text]
  $client.update(@tweet)
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
  erb :index
end

