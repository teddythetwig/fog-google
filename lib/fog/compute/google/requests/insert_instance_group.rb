module Fog
  module Compute
    class Google
      class Mock
        def insert_instance_group(_group_name, _zone, _options = {})
          Fog::Mock.not_implemented
        end
      end

      class Real
        def insert_instance_group(group_name, zone, options = {})
          api_method = @compute.instance_groups.insert
          parameters = {
            "project" => @project,
            "zone" => zone
          }

          id = Fog::Mock.random_numbers(19).to_s

          body = {
            "name" => group_name
          }

          body["description"] = options["description"] if options["description"]
          network_name = options["network"] ? options["network"].split("/")[-1] : GOOGLE_COMPUTE_DEFAULT_NETWORK
          body["network"] = "https://www.googleapis.com/compute/#{api_version}/projects/#{@project}/global/networks/#{network_name}"

          unless options["subnetwork"].nil?
            subnetwork_name = options["subnetwork"].split("/")[-1]
            body["subnetwork"] = "https://www.googleapis.com/compute/#{api_version}/projects/#{@project}/regions/#{@region}/subnetworks/#{subnetwork_name}"
          end

          request(api_method, parameters, body)
        end
      end
    end
  end
end
