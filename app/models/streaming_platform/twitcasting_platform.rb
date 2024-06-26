class StreamingPlatform::TwitcastingPlatform < ::StreamingPlatform
  def fetch_streaming(url)
    StreamingPlatform::TwitcastingDescribeStreaming.new(url).execute
  end

  def download_movie(url, &block)
    StreamingPlatform::TwitcastingDownloadStreaming.new(url).execute(&block)
  end
end
