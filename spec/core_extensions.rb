class Array
  def extract_kwargs!
    last.is_a?(::Hash) ? pop : {}
  end
end