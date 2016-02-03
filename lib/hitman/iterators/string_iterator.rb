class StringIterator
  def random_string(length)
    rand(36**length).to_s(36)
  end

  def get
    ['', random_string(10), random_string(500)]
  end
end
