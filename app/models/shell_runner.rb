class ShellRunner
  def self.run(command)
    Rails.logger.info "[SHELL] #{command}"

    stdout, _stdin, pid = PTY.spawn(command)
    Rails.logger.info stdout.map(&:itself).join
    _, status = Process.wait2(pid)
    status.success?
  rescue Errno::EIO => e
    Rails.logger.error "Error: #{e}"
    false
  end
end
