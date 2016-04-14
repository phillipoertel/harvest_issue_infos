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

  def run
    sum = 0
    puts
    puts "Summary"
    puts "-" * 80
    puts
    task_infos.each do |info|
      puts "#%-5d %-47s %-5s" % [info.issue_number, info.issue_title[0, 45], info.hours.round(2).to_s]
      sum += info.hours
    end
    puts "Total hours: %46s" % sum.round(2).to_s
    puts
    puts
    puts "Details"
    puts "-" * 80
    puts
    task_infos.each do |info|
      title = "##{info.issue_number} #{info.issue_title} (#{info.hours.round(2)}h)"
      puts title
      puts '-' * title.length
      info.time_entries.each do |i|
        puts "%s %s (%sh)" % [i.spent_at, i.notes, i.hours]
      end
      puts
    end
  end

  private

  def task_infos
    @task_infos ||= begin
      Github
        .issues(client_config["repository"], client_config["assignee"])
        .map { |issue| TaskInfo.for(client_config, issue) }
        .reject { |issue| issue.time_entries.empty? }
        .sort_by(&:issue_number)
    end
  end

end