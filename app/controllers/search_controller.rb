class SearchController < ApplicationController
  def new
  end

  def search
    @content = PgSearch.multisearch(params[:query]).select(:content).pluck(:content).join(',')
  end
end
