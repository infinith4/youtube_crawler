# coding: utf-8
require 'google/apis/youtube_v3'
require 'active_support/all'

GOOGLE_API_KEY=""

#https://www.youtube.com/playlist?list=PLluPcob83OE-v_7uuzHQi40Xej2ICJccg
def select_playlist_items(after: 1.months.ago, before: Time.now)
  service = Google::Apis::YoutubeV3::YouTubeService.new
  service.key = GOOGLE_API_KEY
  playlist_item_urls = []
  next_page_token = nil
  begin
    opt = {
      playlist_id: "PLluPcob83OE-v_7uuzHQi40Xej2ICJccg",
      max_results: 50
    }
    results = service.list_playlist_items(:snippet, opt)
    results.items.each do |item|
      snippet = item.snippet
      puts "\"#{snippet.title}\" by #{snippet.channel_title} (#{snippet.published_at})"
      puts "\"#{item.id}\""
      url = "\"https://www.youtube.com/watch?v=#{snippet.resource_id.video_id}\""
      puts url
      playlist_item_urls.push(url)
    end

    next_page_token = results.next_page_token
  end while next_page_token.present?
  return playlist_item_urls
end

urls = select_playlist_items()

urls.each {|url|
  puts url
  system("youtube-dl -t #{url} -x --audio-format mp3")
}
