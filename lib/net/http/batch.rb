require 'net/http/persistent'
require 'thread'

class Net::HTTP::Batch

  def initialize batch_size = 10
    @batch_size = batch_size
    @queue = Queue.new
    @results = Queue.new
  end

  def request *args
    @queue << args
    self
  end

  def run
   threads = Array.new(@batch_size) { worker }
    until @queue.empty? && @queue.num_waiting == @batch_size
      threads.each { |t| t.join(0.1) }
    end
    @batch_size.times { @queue << nil }
    threads.each { |t| t.join }
    Array.new(@results.size) { @results.pop }
  end

  private
  def worker
    Thread.new do
      http = Net::HTTP::Persistent.new
      while args = @queue.pop
        @results << http.request(*args)
      end
      # http.shutdown # XXX disabled due to net-http-persistent bug
    end
  end

end
