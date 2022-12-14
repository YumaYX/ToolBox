require 'open-uri'
require 'json'

class Topsongs

  def initialize
    content=String.new
    url = 'https://rss.applemarketingtools.com/api/v2/jp/music/most-played/100/songs.json'
    # url = './songs.json'
    content = URI.open(url).read
    hash = JSON.parse(content)
    i = 1
    @@ranking = Hash.new
    hash['feed']['results'].each do |item|
      artistname_name="#{item['name']} - #{item['artistName']}"
      unless @@ranking.has_key?(artistname_name) then
        @@ranking[artistname_name] = i
        i+=1
      end
    end
      @@json_file_path='./result.json'
  end

  def get_ranking
    @@ranking
  end

  def get_old_ranking
    json_data = open(@@json_file_path) do |io|
      JSON.load(io)
    end
    json_data
  end

  def save_ranking
    open(@@json_file_path, 'w') do |io|
      JSON.dump(@@ranking, io)
    end
  end

  def get_ranking_with_vari
    hash = Hash.new
    old_ranking = get_old_ranking
    @@ranking.each do |key, value|
      if old_ranking.has_key?(key) then
        if old_ranking[key] == value then
          hash[key]="#{value}(→)"
        elsif old_ranking[key] < value then
          hash[key]="#{value}(↓)"
        else
          hash[key]="#{value}(↑)"
        end
      else
        hash[key]="#{value}(N)"
      end
    end
    hash
  end
end


t=Topsongs.new

# Top100
t.get_ranking.each do |k,v|
  puts "#{v}:\t#{k}"
end

# Top100 with variation
t.get_ranking_with_vari.each do |k,v|
  puts "#{v}:\t#{k}"
end

# to save ranking
t.save_ranking
