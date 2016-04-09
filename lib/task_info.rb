require 'harvest/api_client'
require 'time_entry'

# given a task id, returns the harvest time entries and the sum of work
class TaskInfo

  def self.for(project_id, gh_issue)
    new(project_id, gh_issue)
  end

  def initialize(project_id, gh_issue)
    @project = harvest.projects.all.find { |p| p.id == project_id }
    @gh_issue = gh_issue
  end

  def time_entries
    # FIXME adapt time range
    @entries ||= begin
      report = harvest.reports.time_by_project(@project, start_date, end_date)
      entries_for_issue = report.select { |e| e.notes =~ /##{@issue_number}/ }
      entries_for_issue.map { |e| TimeEntry.new(e, @issue_number) }
    end
  end

  def issue_number
    @gh_issue.number
  end

  def issue_title
    @gh_issue.title
  end

  def hours
    time_entries.inject(0) { |sum, entry| sum += entry.hours; sum}
  end

  private

  def harvest
    Harvest::ApiClient.instance
  end

  def start_date
    Time.parse("2016-03-29")
  end

  def end_date
    Date.today
  end

end



__END__

--- !ruby/hash:Harvest::TimeEntry
spent_at: 2016-03-29
id: 444690167
notes: Sync Ralf, date/time picker for tasks discussion
hours: 1.0
user_id: 307047
project_id: 10151221
issue_number: 1251025
created_at: '2016-03-29T15:02:56Z'
updated_at: '2016-03-29T15:02:56Z'
adjustment_record: false
timer_started_at:
is_closed: false
is_billed: false
started-at: '11:30