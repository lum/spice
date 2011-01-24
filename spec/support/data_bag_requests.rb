def stub_data_bag_list
  stub_request(:get, "http://localhost:4000/data").
  to_return(
    :status => 200,
    :body => data_bag_list_response)
end

def stub_data_bag_show(status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/data/users").
      to_return(
        :status => status,
        :body => data_bag_show_response)
  when 404
    stub_request(:get, "http://localhost:4000/data/users").
      to_return(
        :status => status,
        :body => %Q{{"errors":["Cannot load data bag users"]}})
  end
end

def stub_data_bag_create(status=201)
  case status
  when 201
    stub_request(:post, "http://localhost:4000/data").
      with(
        :body => data_bag_create_payload).
      to_return(
        :status => status, 
        :body => data_bag_create_response)
  when 409
    stub_request(:post, "http://localhost:4000/data").
      with(
        :body => data_bag_create_payload).
      to_return(
        :status => status, 
        :body => %Q{"error":["Cannot create data bag users"]})
  end
end

def stub_data_bag_item_create
  case status
  when 201
    stub_request(:post, "http://localhost:4000/data/users").
      with(
        :body => data_bag_item_create_payload).
      to_return(
        :status => status, 
        :body => data_bag_item_create_response)      
  when 404
    stub_request(:post, "http://localhost:4000/data/users").
      with(
        :body => data_bag_item_create_payload).
      to_return(
        :status => status, 
        :body => %Q{"error":["Cannot find data bag users]})
  when 409
    stub_request(:post, "http://localhost:4000/data").
      with(
        :body => data_bag_item_create_payload).
      to_return(
        :status => status, 
        :body => %Q{"error":["Cannot create data bag item adam"]})
  end
end

# def stub_data_bag_update(name, admin=false, private_key=false, status=200)
#   case status
#   when 200
#     stub_request(:put, "http://localhost:4000/data/#{name}").
#       with(:body => "{"admin":#{admin},"private_key":#{private_key}}").
#       to_return(
#         :status => status,
#         :body => %Q{{#{""private_key":"RSA PRIVATE KEY"," if private_key}"admin": true}
#         }
#       )
#   # when 404
#   #     stub_request(:get, "http://localhost:4000/data/#{name}").
#   #     to_return(
#   #       :status => status,
#   #       :body => "{"error":["Cannot load client #{name}"]}")
#   end
# end
# 
# def stub_data_bag_delete(name, status=200)
#   case status
#   when 200
#     stub_request(:delete, "http://localhost:4000/data/#{name}").
#       with(:body => "").
#       to_return(
#         :status => status,
#         :body => ""
#       )
#   when 404
#     stub_request(:delete, "http://localhost:4000/data/#{name}").
#       with(:body => "").
#       to_return(
#         :status => status,
#         :body => "{"error":["Cannot load data bag sasdasdf"]}"
#       )
#   end
# end


# payloads and responses

def data_bag_list_response
  {
    "users" => "http://localhost:4000/data/users",
    "applications" => "http://localhost:4000/data/applications"
  }
end

def data_bag_show_response
  { "adam" => "http://localhost:4000/data/users/adam" }
end

def data_bag_create_payload
  { "name" => "users" }
end

def data_bag_create_response
  { "uri" => "http://localhost:4000/data/users" }
end

def data_bag_item_create_payload
  { "id" => "adam", "real_name" => "Adam Jacob" }
end