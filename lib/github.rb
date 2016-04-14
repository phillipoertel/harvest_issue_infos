require 'octokit'

class Github

  include Singleton

  def self.issues(repository, assignee)
    instance.issues(repository, assignee)
  end

  def initialize
    @issues = {}
  end

  def issues(repository, assignee)
    @issues[repository] ||= Octokit.issues(repository, assignee: assignee, state: :all, per_page: 100)
  end

end

__END__


Github issue getter methods:
url
repository_url
labels_url
comments_url
events_url
html_url
id
number
title
user
labels
state
locked
assignee
milestone
comments
created_at
updated_at
closed_at
body