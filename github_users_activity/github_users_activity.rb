#!/usr/bin/env ruby

require 'json'
require 'rest-client'

ACCESS_TOKEN = '' # <----------------- put your access_token here
puts "be sure you setup ACCESS_TOKEN inside the script (https://help.github.com/articles/creating-an-access-token-for-command-line-use/)"
puts "type 'exit' for quit"

class GithubInvalidResponse < StandardError; end
def user_repos_url username
  "https://api.github.com/users/#{username}/repos?access_token=#{ACCESS_TOKEN}"
end

def repo_participation_url username, repo
  "https://api.github.com/repos/#{username}/#{repo}/stats/participation?access_token=#{ACCESS_TOKEN}"
end

loop do
  puts "\nEnter github usernames:"
  input = $stdin.gets.chomp

  break if input == 'exit'

  usernames = input.split(',').map(&:strip)

  activity = usernames.map do |username|
    repos_data = JSON.parse(RestClient.get(user_repos_url(username)))
    repos_names = repos_data.map {|repo| repo['name']}

    puts "proceed #{username} with #{repos_names.size} repos"

    commits_count = repos_names.inject(0) do |sum, repo|
      begin
        tries ||= 5
        commits_data = JSON.parse(RestClient.get(repo_participation_url(username, repo)))

        raise GithubInvalidResponse if commits_data == {}

        commits_data_count = commits_data['owner'].reduce(:+)
      rescue GithubInvalidResponse => e
        retry unless (tries -= 1).zero?

        puts "wrong commits count for repo #{repo}, assume as 0"
        commits_data_count = 0
      end

      sum + commits_data_count
    end

    {username: username, commits_count: commits_count}
  end

  sorted_activity = activity.sort_by {|user_activity| user_activity[:commits_count] }.reverse

  puts "\nResult:"
  sorted_activity.each do |user_activity|
    puts "#{user_activity[:username]}: #{user_activity[:commits_count]}"
  end
end
