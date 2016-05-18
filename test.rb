require 'net/http'

project_id = 'xxxx'
story_id = 'xxxx'
story_name = ''
story_url = "https://www.pivotaltracker.com/story/show/#{story_id}"

begin
  url = URI.parse("https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories/#{story_id}")
  https = Net::HTTP.new(url.host, 443)
  https.use_ssl = true
  result = JSON(https.get(url.path, 'X-TrackerToken' => ENV['PT_TOKEN']).body)
  story_name = result['name']
rescue
end

title = "[fixed ##{story_id}]#{story_name}"
