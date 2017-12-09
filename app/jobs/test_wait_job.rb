class TestWaitJob < ApplicationJob
  @@job_running = false

  queue_as :default

  def perform
    if @@job_running
      raise "These jobs cannot run simultaneously!"
    end
    @@job_running=true
    puts("JOB STARTED")

    sleep 10.seconds

    @@job_running=false
    puts("JOB ENDED")
  end
end
