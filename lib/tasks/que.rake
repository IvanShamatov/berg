namespace :que do
  task :environment do
    require_relative "../../component/boot"
  end

  desc "Process Que's jobs using a worker pool"
  task work: :environment do
    Que.worker_count  = (ENV["QUE_WORKER_COUNT"] || 4).to_i
    Que.wake_interval = (ENV["QUE_WAKE_INTERVAL"] || 0.1).to_f
    Que.mode          = :async

    # When changing how signals are caught, be sure to test the behavior with
    # the rake task in tasks/safe_shutdown.rb.

    stop = false
    %w(INT TERM).each do |signal|
      trap(signal) { stop = true }
    end

    at_exit do
      $stdout.puts "Finishing Que's current jobs before exiting..."
      Que.worker_count = 0
      Que.mode = :off
      $stdout.puts "Que's jobs finished, exiting..."
    end

    loop do
      sleep 0.01
      break if stop
    end
  end
end
