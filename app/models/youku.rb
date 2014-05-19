class Youku < Video

  def initialize(options = {})
    url = options.delete(:url)
    super(options)
    self.ori_id = url.match(/id_\w+/).to_s.delete('id_') if url.present?
  end

  private

end
