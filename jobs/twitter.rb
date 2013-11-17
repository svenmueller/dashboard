require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
Twitter.configure do |config|
  config.consumer_key = 'QEeTIoGMlhs50bw2jxlNKA'
  config.consumer_secret = ''
  config.oauth_token = '14401202-cXLxsGhUrFs52Pww2LFBWd93L0OwhP77Kwk5AV9XI'
  config.oauth_token_secret = ''
end

search_term = URI::encode('#commercetools OR @commercetools OR #sphereio OR @sphereio')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = Twitter.search("#{search_term}").results

    if tweets
      tweets.map! do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end