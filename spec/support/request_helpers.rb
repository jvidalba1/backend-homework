module RequestHelpers
  def json_response
    resp = JSON.parse(response.body).with_indifferent_access
    resp[:data]
  end
end
