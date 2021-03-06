module Fog
  module Storage
    class GoogleJSON
      class Real
        # Get an expiring object url from Google Storage for putting an object
        #
        # ==== Parameters
        # * bucket_name<~String> - Name of bucket containing object
        # * object_name<~String> - Name of object to get expiring url for
        # * expires<~Time> - An expiry time for this url
        # * If you want a file to be public you should to add { 'x-goog-acl' => 'public-read' } to headers
        #   And then call for example: curl -H "x-goog-acl:public-read" "signed url"
        #
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~String> - url for object
        #
        # ==== See Also
        # https://cloud.google.com/storage/docs/access-control#Signed-URLs
        #
        def put_object_url(bucket_name, object_name, expires, headers = {})
          raise ArgumentError.new("bucket_name is required") unless bucket_name
          raise ArgumentError.new("object_name is required") unless object_name
          https_url({
                      :headers  => headers,
                      :host     => @host,
                      :method   => "PUT",
                      :path     => "#{bucket_name}/#{object_name}"
                    }, expires)
        end
      end

      class Mock
        def put_object_url(bucket_name, object_name, expires, headers = {})
          raise ArgumentError.new("bucket_name is required") unless bucket_name
          raise ArgumentError.new("object_name is required") unless object_name
          https_url({
                      :headers  => headers,
                      :host     => @host,
                      :method   => "PUT",
                      :path     => "#{bucket_name}/#{object_name}"
                    }, expires)
        end
      end
    end
  end
end
