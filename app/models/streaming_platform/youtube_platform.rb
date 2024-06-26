class StreamingPlatform::YoutubePlatform < ::StreamingPlatform
  class NotLiveResult
    def streaming?
      false
    end
  end

  def download_movie(*)
    Rails.logger.error 'youtubeは未対応です'
    nil
  end

  def fetch_streaming(*)
    Rails.logger.error 'youtubeは未対応です'
    NotLiveResult.new
  end
end
