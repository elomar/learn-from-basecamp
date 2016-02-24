module DocumentsHelper
  def byline(document)
    [(document.author ? "by #{document.author}" : nil),
      (document.source ? "at #{document.source}" : nil),
      (document.published_on ? "on #{I18n.l document.published_on}" : nil)].
      compact.
      join(", ")
  end
end
