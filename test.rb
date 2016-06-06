require 'net/http'
require 'json'

PULL_REQUEST_TEMPLATE = 'PULLREQ_EDITMSG'

def get_story_id
  current_branch = `git symbolic-ref --short HEAD`
  current_branch.match(/(\d+)/)
  $1
end

def get_story_name(story_id)
  story_name = nil

  url = URI.parse("https://www.pivotaltracker.com/services/v5/projects/#{ENV['PT_PROJECT_ID']}/stories/#{story_id}")
  https = Net::HTTP.new(url.host, 443)
  https.use_ssl = true
  result = JSON(https.get(url.path, 'X-TrackerToken' => ENV['PT_TOKEN']).body)
  puts result
  story_name = result['name']
end

def write_pull_request_template(story_id, story_name)
  open(template_path, 'w') do |file|
    file.puts "[fixed ##{story_id}]#{story_name}"
    file.puts "\n"
    file.puts "https://www.pivotaltracker.com/story/show/#{story_id}"
  end
end

def template_path
  File.join(Dir.pwd, '.git', PULL_REQUEST_TEMPLATE)
end

story_id = get_story_id
if story_id
  story_name = get_story_name(story_id)
  write_pull_request_template story_id, 'test'

  if story_name
    write_pull_request_template story_id, story_name
  end
end

system 'hub pull-request --browse'
