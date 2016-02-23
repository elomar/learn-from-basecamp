class DocumentsController < ApplicationController
  helper DocumentsHelper

  def index
    if params[:search].present?
      @query = search_params[:query]
      @documents = Document.search(search_params)
    else
      @documents = Document.all
    end
  end

  protected

  def search_params
    params.require(:search).permit([:query])
  end
end
