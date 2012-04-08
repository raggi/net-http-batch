require 'minitest/autorun'
require 'net/http/batch'
require 'puma'

class TestNetHttpBatch < MiniTest::Unit::TestCase

  class App
    attr_reader :requests

    def initialize
      @requests = 0
      @required = 3
      @mutex = Mutex.new
    end

    def call env
      incr
      Thread.pass until @requests >= @required
      [200, {'Content-Type' => 'text/plain'}, %w[hello world]]
    end

    def incr
      @mutex.synchronize { @requests += 1 }
    end
  end

  def app
    @app ||= App.new
  end

  def http
    @http ||= Net::HTTP::Batch.new
  end

  def localhost
    @localhost ||= URI "http://127.0.0.1:#{free_port}/"
  end

  def free_port
    TCPServer.open("127.0.0.1", 0) { |s| s.addr[1] }
  end

  def get path = '/'
    Net::HTTP::Get.new path
  end

  def setup
    @server = Puma::Server.new app
    @server.add_tcp_listener localhost.host, localhost.port
    Thread.new { @server.run }
    Thread.pass until @server.running
  end

  def teardown
    @server.stop true if @server
  end

  def test_batch_of_three
    3.times { http.request localhost, get }
    results = http.run.map { |response| response.body }
    assert_equal 3, app.requests
    expected = Array.new(3) { "helloworld" }
    assert_equal expected, results
  end

end
