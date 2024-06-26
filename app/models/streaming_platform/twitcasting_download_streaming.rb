class StreamingPlatform::TwitcastingDownloadStreaming
  class DownloadError < StandardError; end

  def initialize(url)
    @url = url
  end

  def execute
    Rails.logger.info "Downloading streaming: #{@url}"
    file_name_part = @url.match(%r{/([^/]+?)$})[1]
    output_path = "#{Rails.root}/tmp/live-stream#{file_name_part}.mp4"
    command = "yt-dlp \"#{@url}\" -o '#{output_path}'"
    raise DownloadError, "Failed to download streaming" unless ShellRunner.run(command)

    if block_given?
      yield output_path
      FileUtils.rm_f(output_path)
    else
      Rails.logger.warn "you need to remove #{output_path} manually!"
    end

    Rails.logger.info "Downloaded streaming: #{output_path}"

    output_path
  end
end
