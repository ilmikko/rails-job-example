class DatabaseInsertJob < ApplicationJob
  queue_as :default

  def perform()
    # Do something later
    i = 0
    while DatabaseItem.exists? integer:i
      i += 1
    end
    DatabaseItem.create(integer:i,string:"This is a string")
  end
end
