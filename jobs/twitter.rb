require 'twitter'

credentials_file = File.dirname(File.expand_path(__FILE__)) + '/../credentials.yml'
credentials = YAML::load(File.open(credentials_file))


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = credentials['twitter']['consumer']['key']
  config.consumer_secret = credentials['twitter']['consumer']['secret']
  config.oauth_token = credentials['twitter']['oauth']['token']
  config.oauth_token_secret = credentials['twitter']['oauth']['secret']
end

search_term = URI::encode('#commercetools OR @commercetools OR #sphereio OR @sphereio')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end