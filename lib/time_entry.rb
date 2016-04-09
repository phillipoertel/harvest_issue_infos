class TimeEntry

  attr_reader :entry
  
  def initialize(entry, issue_number)
    @entry   = entry
    @issue_number = issue_number
  end

  def notes
    n = entry.notes.gsub(/\s*#\d+\s*/, '').gsub("\n", ' ')
    n = "[no_description]" if n =~ /^\s*$/
    n.length >= 60 ? n[0, 57] + "..." : n[0, 60]
  end

  def issue_number
    @issue_number
  end

  def hours
    entry.hours
  end

  def spent_at
    entry.spent_at
  end

end

