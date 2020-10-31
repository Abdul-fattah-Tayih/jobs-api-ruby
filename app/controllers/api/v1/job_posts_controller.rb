module Api
  module V1
    class JobPostsController < ApplicationController
      alias_method :current_user, :current_api_v1_user
      load_and_authorize_resource
      skip_authorize_resource :only => :show
      def index
        @job_posts = JobPost.order('created_at DESC')
        render json: @job_posts
      end

      def show
        @job_post = JobPost.find(params[:id])
        render json: @job_post
      end

      def create
        @job_post = JobPost.new(job_post_params)
        if @job_post.save
          render json: @job_post, status: :created
        end

        render json: { status: :bad_request, errors: @job_post.errors }
      end

      def update
        @job_post = JobPost.find(params[:id])
        if @job_post.update_attributes(job_post_params)
          render json: @job_post
        end

        render json: { status: :bad_request, errors: @job_post.errors }
      end

      def destroy
        JobPost.find(params[:id]).destroy
        head :no_content
      end

      private

      def job_post_params
        params.permit(:title, :description, :expires_at)
      end
    end
  end
end
