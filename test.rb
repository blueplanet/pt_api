#! /bin/ruby
require 'net/http'

class PivotalTracker
  PROJECT_ID = 'xxxx'
  PULL_REQUEST_TEMPLATE = '.pull_requestf_message'

  def initialize
    current_branch = `git symbolic-ref --short HEAD`
    @story_id = current_branch.scan(/(\d+)/).first
  end

  def story_name(story_id)
    story_name = ''

    url = URI.parse("https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories/#{story_id}")
    https = Net::HTTP.new(url.host, 443)
    https.use_ssl = true
    result = JSON(https.get(url.path, 'X-TrackerToken' => ENV['PT_TOKEN']).body)
    story_name = result['name']
  rescue
    nil
  end

  def write_pull_request_template
    open(File.join(File.pwd, '.git', PULL_REQUEST_TEMPLATE), 'w') do |file|
      file.puts "[fixed ##{story_id}]#{story_name}"
      file.puts "\n"
      file.puts "https://www.pivotaltracker.com/story/show/#{story_id}"
    end
  end
end
