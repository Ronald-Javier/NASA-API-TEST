require 'uri'
require 'net/http'
require 'json'
require_relative 'helpers'


def request(url, api_key)
    url = URI(url + '&api_key=' + api_key)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    JSON.parse(response.read_body)
end