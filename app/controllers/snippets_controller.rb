class SnippetsController < ApplicationController

  before_filter :ensure_owner, :except => [:index,:new,:create]
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
      @snippets = Snippet.where(:language => params[:language], :user_id => current_user.id)
      @selected_language = params[:language]
    else
      @snippets = Snippet.where(:user_id => current_user.id)
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

  private
  def ensure_owner
    @snippet =  Snippet.find(params[:id])
    raise "Permission Error" unless @snippet.user == current_user
  end
end
