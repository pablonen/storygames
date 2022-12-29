class SearchController < ApplicationController
  def new
  end

  def search
    @documents = PgSearch.multisearch(params[:query])
  end
end
