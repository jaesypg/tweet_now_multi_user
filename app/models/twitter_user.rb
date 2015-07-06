class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  # def fetch_tweets!(username)
  def fetch_tweets!
    # @twitteruser = TwitterUser.find_by_username(username)
    # @recent = $client.user_timeline(username).take(10)
    # @recent.each do |tw|
    #   @twitteruser.tweets.create(text: tw.text)
    # end
    Tweet.destroy(self.tweets)
    @recent = $client.user_timeline(self.username).take(10)
    @recent.each do |tw|
      self.tweets.create(text: tw.text)
    end
  end

  def tweets_stale?
    if self.tweets.empty?
      return true
    else
      # if (self.tweets.first.created_at + 15.minutes) < Time.now
      #   return true
      # else
      #   return false
      # end
      # if (self.tweets.first.created_at + 15.minutes) < Time.now ? true : false
      self.tweets.order_by
      if (self.tweets.first.created_at + 15.minutes) < Time.now
        return true
      else
        return false
      end
    end
  end
end
