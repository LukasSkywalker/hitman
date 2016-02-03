module Hitman
  class Request
    def self.get(uri)
      Net::HTTP.get_response(uri)
    end

    def self.post(uri, payload)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(
        uri.request_uri,
        initheader = {'Content-Type' => 'application/json'}
      )
      request.body = payload

      http.request(request)
    end
  end
end
