class SnippetsController < ApplicationController
  def new
    @snippet = Snippet.new
  end

  def create
    Snippet.create(params[:snippet])
    redirect_to snippets_path
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def index
    @snippets = Snippet.all
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
