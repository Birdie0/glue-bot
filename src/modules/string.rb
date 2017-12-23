# add normalize method because
class String
  def normalize!
    replacements = [
      ["\r\n", "\n"],
      ['&lt;', '<'],
      ['&gt;', '>'],
      ['&#39;', "'"],
      ['&quot;', '"'],
      ['&amp;', '&'],
      ['&#160', "\u{00A0}"]
    ]
    replacements.map { |i| gsub!(i[0], i[1]) }
  end
end
