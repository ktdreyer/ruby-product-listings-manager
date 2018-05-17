require "benchmark"
require "xmlrpc/client"
require "product_listings_manager/version"


class ProductListingsManager

  attr_reader :time

  # warning, https://bugzilla.redhat.com/show_bug.cgi?id=1091531#c8
  def initialize(url, timeout=120)
    timeout = timeout
    @server = XMLRPC::Client.new2(url, nil, timeout)
    @proxy = @server.proxy
  end

  def method_missing(name, *args)
    result = nil
    @time = Benchmark.realtime do
      result = @proxy.send(name, *args)
    end
    return result
  end

end
