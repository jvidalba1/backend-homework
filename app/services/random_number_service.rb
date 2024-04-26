require 'net/http'

class RandomNumberService < ApplicationService
  URL_BASE = 'http://www.randomnumberapi.com/api/v1.0/random'.freeze

  def initialize(min = 0, max = 50)
    @min = min
    @max = max
  end

  def call
    return success(parse_response(number))
  end

  private

  def number
    uri = URI(URL_BASE)
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    res.body
  rescue Net::HTTPError => e
    return failure(e.message)
  end

  private

  def parse_response(res)
    JSON.parse(res)
  end

  def params
    { :min => @min, :max => @max }
  end
end
