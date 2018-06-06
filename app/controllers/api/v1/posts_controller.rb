module Api
  module V1
    class PostsController < LoggedInController

      ##
      # GET /api/v1/posts/page
      def page
        render :json => {
            :success => true,
            :posts => Post.page(params[:page].to_i).as_json
        }
      end

      ##
      # POST/GET /api/v1/posts/user
      def user
        render :json => {
            :success => true,
            :posts => current_user.posts.page(params[:page].to_i).as_json
        }
      end

      ##
      # POST /api/v1/posts
      #
      # params = {
      #   title: "Post Title",
      #   body: "Post Body"
      # }
      def create
        post = Post.new(post_params.merge(user_id: current_user.id))

        if post.save!
          render :json => {:success => true, :post => post}
        else
          render :json => {:success => false, :message => "Error creating post."}, :status => 500
        end
      end

      ##
      # GET /api/v1/posts/1
      def show
        render :json => {
            :success => true,
            :post => Post.find(params[:id].to_i)
        }
      end

      private

      def post_params
        params.require(:post).permit(:title, :body)
      end

    end
  end
end
