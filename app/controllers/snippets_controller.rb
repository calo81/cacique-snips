class SnippetsController < ApplicationController
  def new
    @snippet = Snippet.new
  end

  def create
    snippet = Snippet.new(params[:snippet].merge!(:user => current_user))
    snippet.save
    redirect_to snippets_path
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def index
    if(params[:language])
      @snippets = Snippet.where(:language => params[:language])
      @selected_language = params[:language]
    else
      @snippets = Snippet.all
      @selected_language = 'ruby'
    end
  end

  def edit
    @snippet = Snippet.find(params[:id])
  end

  def destroy
    Snippet.delete(params[:id])
    redirect_to snippets_path
  end

  def update
    @snippet = Snippet.find(params[:id])
    @snippet.update_attributes(params[:snippet])
    @snippet.save
    redirect_to snippets_path
  end
end
