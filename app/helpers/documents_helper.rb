module DocumentsHelper
  def byline(document)
    [(document.author ? "by #{search(document.author)}" : nil),
      (document.source ? "at #{search(document.source)}" : nil),
      (document.published_on ? "on #{I18n.l(document.published_on, format: :long)}" : nil)].
      compact.
      join(", ")
  end

  def search(query)
    link_to query, root_url(search: { query: query })
  end
end
