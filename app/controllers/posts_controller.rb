class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    #pass the option parameter z serializer indicating that
    #we want to include those objects
    options = {
    include: [:user]
    }
    
    #uses the post serializer from serializer folder 
    render json: PostSerializer.new(@posts, options)
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @user = User.find_or_create_by(username: params[:post][:username])
    @post = @user.posts.new(post_params)

    if @post.save
       options = {
                  include: [:user]
                  }
    
    #uses the post serializer from serializer folder 
    render json: PostSerializer.new(@posts, options)

    else

      #notifay the speicfic error  
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
