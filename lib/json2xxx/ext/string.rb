class String
  REGEXP_PATTERN = /\e\[([;\d]+)?m/

  def uncolorize
    self.gsub(REGEXP_PATTERN, '')
  end
end
