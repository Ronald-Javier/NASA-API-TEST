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


def buid_web_page(step1)

    clean_data = step1['photos']    
    photo_info = {}                     
    photo_src = []                      
    
    clean_data.each do |i|              
        photo_info = i
        photo_src.push(photo_info['img_src']) 
    end

   
   web1 = File.open('photos.html', 'w') do |f|
   web2 = File.open('style.css', 'w') do |x|

    x.puts css_body

        f.puts head                     
    
            f.puts "<h1 class='text-light'>FOTOS DE LA NASA!</h1>
            <ul>"
            photo_src.each do |i|
            f.puts "<li><img src='#{i}' width='900' alt='Nasa Photos'></li>"
            f.puts '</ul><br>'
        end

        f.puts footer                   
    end
end
end