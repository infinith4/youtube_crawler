# coding: utf-8
require 'google/apis/youtube_v3'
require 'active_support/all'

GOOGLE_API_KEY=""

def find_videos(after: 1.months.ago, before: Time.now)
  service = Google::Apis::YoutubeV3::YouTubeService.new
  service.key = GOOGLE_API_KEY

  next_page_token = nil
  begin
    opt = {
      channel_id: "UComEqi_pJLNcJzgxk4pPz_A",
      max_results: 50
    }
    results = service.list_playlists(:snippet, opt)
    results.items.each do |item|
      snippet = item.snippet
      puts "\"#{snippet.title}\" by #{snippet.channel_title} (#{snippet.published_at})"
    end

    next_page_token = results.next_page_token
  end while next_page_token.present?
end

find_videos()
