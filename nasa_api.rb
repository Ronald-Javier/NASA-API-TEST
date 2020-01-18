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


def buid_web_page(step_one)

    clean_data = step_one['photos']    
    photo_info = {}                     
    photo_src = []                      
    
    clean_data.each do |data|              
        photo_info = data
        photo_src.push(photo_info['img_src']) 
    end

   
   web1 = File.open('photos.html', 'w') do |f|
   web2 = File.open('style.css', 'w') do |x|

    x.puts css_body

        f.puts head                     
    
            f.puts "<h1 class='text-light'>FOTOS DE LA NASA!</h1>
            <ul>"
            photo_src.each do |img|
            f.puts "<li><img src='#{img}' width='900' alt='Nasa Photos'></li>"
            f.puts '</ul><br>'
        end

        f.puts footer                   
    end
end
end

def photos_count (step_two)             
    info = {}          
    camara_name = []
    step_two['photos'].each do |i|
        info = i
        camara_name.push(info['camera'])
    end
    
    total = Hash.new(0)
    camara_name.each do |num|
        total[num] += 1
    end
    total.each do |name, num|
        puts "Hay #{num} fotos de la camara #{name['name']}"
    end
end


photos_count(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10', 'bkghKA5LCY3f6sDu98THinoxnmueTzk0f53xZ5Uy'))


buid_web_page(request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10', 'bkghKA5LCY3f6sDu98THinoxnmueTzk0f53xZ5Uy'))

