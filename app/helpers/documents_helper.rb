module DocumentsHelper
  def byline(document)
    [(document.author ? "by #{document.author}" : null),
      (document.source ? "at #{document.source}" : null),
      (document.published_on ? "on #{I18n.l document.published_on}" : null)].
      compact.
      join(", ")
  end
end
