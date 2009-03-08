require 'rack/request'
require 'rack/cache/headers'
require 'rack/cache/cachecontrol'

module Rack::Cache

  # Provides access to the HTTP request. The +request+ and +original_request+
  # objects exposed by the Core caching engine are instances of this class.
  #
  # Request objects respond to a variety of convenience methods, including
  # everything defined by Rack::Request as well as the Headers and
  # RequestHeaders modules.
  class Request < Rack::Request
    # The HTTP request method. This is the standard implementation of this
    # method but is respecified here due to libraries that attempt to modify
    # the behavior to respect POST tunnel method specifiers. We always want
    # the real request method.
    def request_method
      @env['REQUEST_METHOD']
    end

    # A CacheControl instance based on the request's Cache-Control header.
    def cache_control
      @cache_control ||= CacheControl.new(env['HTTP_CACHE_CONTROL'])
    end
  end
end
