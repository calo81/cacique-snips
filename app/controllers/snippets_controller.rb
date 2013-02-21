class SnippetsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :ensure_owner, :only => [:update,:destroy]
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
    user_id = current_user ? current_user.id : -1
    if(params[:language])
      @snippets = Snippet.where(:language => params[:language]).by_owner_or_public(user_id)
      @selected_language = params[:language]
    else
      @snippets = Snippet.by_owner_or_public(user_id)
    end
    all_snippets = Snippet.by_owner_or_public(user_id)
    @languages = all_snippets.group_by(&:language)
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

  private
  def ensure_owner
    @snippet =  Snippet.find(params[:id])
    raise "Permission Error" unless @snippet.user == current_user
  end
end
