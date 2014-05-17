class Youku < Video

  def initialize(url)
    @ori_id = url.match(/id_\w+/).to_s.delete('id_')
  end
end
