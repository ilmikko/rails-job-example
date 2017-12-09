# README

## Problem
Try opening the console and performing the following commands.

`TestWaitJob.perform_later`
`2.times{TestWaitJob.perform_later}`
`3.times{TestWaitJob.perform_later}`
(TestWaitJob waits for 5 seconds to succeed, simulating a process that only can run one at a time)

You'll find that Rails sometimes starts multiple of these jobs simultaneously, resulting in an error.

`DatabaseInsertJob.perform_later`
`2.times{DatabaseInsertJob.perform_later}`
`3.times{DatabaseInsertJob.perform_later}`
(DatabaseInsertJob checks the database if entries exist and then inserts a new item into the database)

You'll find that Rails again performs some of these simultaneously, resulting in a freeze
(deadlock situation) in the database, and an error similar to this:
`ActiveRecord::StatementInvalid (SQLite3::BusyException: database is locked: INSERT INTO "database_items"`

## Solution
I see two solutions:

1. Make the jobs run ONE AT A TIME in ALL CASES. No parallel jobs are allowed.

This might be possible using queues, there might be settings for a specific queue.

2. Allow jobs to run in parallel, but change the transaction code in app/jobs/database_insert_job.rb to wait for the db to be unlocked.

If there is a proper way to commit a single transaction / queue transactions in the database, I'd be happy to hear about it.
I've tried DatabaseItem.transaction do ... end, but that didn't fix the problem. On the other hand, having a LOT of jobs waiting for "their turn" to commit a transaction does defeat the purpose of having a queue in the first place.
