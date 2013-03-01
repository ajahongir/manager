class PostsController < ApplicationController

  def index
    get_posts
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to :posts, notice: t("controllers.posts.flash.create")
    else
      render action: :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to :posts, notice: t("controllers.posts.flash.update")
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    if @post.busy?
      flash[:error] = t("controllers.posts.flash.busy")
    else
      @post.destroy
      flash[:notice] = t("controllers.posts.flash.delete")
    end

    get_posts
    render :index
  end

private

  def get_posts
    @posts = Post.removable.paginate(page: params[:page])
  end

end
