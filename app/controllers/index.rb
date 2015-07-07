get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/' do
  # @username = params[:username]
  redirect to "/#{params[:username]}"
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

