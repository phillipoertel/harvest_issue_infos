require 'github'
require 'task_info'

class Runner

  attr_reader :client_config

  def self.run(client_config)
    new(client_config).run
  end

  def initialize(client_config)
    @client_config = client_config
  end

  # TOOO
  # - list total summary
  # - list untagged entries
  def run
    task_infos.each do |info|
      puts "##{info.issue_number}: #{info.issue_title}"
      puts "Total hours: #{info.hours.round(2)}h"
      puts "-" * 80
      info.time_entries.each do |i|
        puts "%s %s (%sh)" % [i.spent_at, i.notes, i.hours]
      end
      puts
    end
  end

  private

  def task_infos
    @task_infos ||= begin
      issues = Github.issues(client_config["repository"], client_config["assignee"])
      issues.map { |issue| TaskInfo.for(client_config["harvest_client_id"], issue) }
    end
  end

end