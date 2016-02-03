class IntegerIterator
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1

  def get
    [MIN, -1, 0, 1, MAX]
  end
end
