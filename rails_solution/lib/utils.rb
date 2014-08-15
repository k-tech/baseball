module Utils
  def meature_time &block
    _start = Time.now
    block.call
    return Time.now - _start
  end
end
