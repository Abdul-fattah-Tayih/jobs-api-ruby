module Api
  module V1
    class JobApplicationsController < ApplicationController
      alias_method :current_user, :current_api_v1_user
      load_and_authorize_resource

      def index
        @job_applications = JobApplication.all
        render json: @job_applications
      end

      def show
        @job_application = JobApplication.find(params[:id])
        render json: @job_application.as_json(include: %i[user job_post])
      end

      def create
        # TODO add user association from current_user
        @job_application = JobApplication.new(job_application_params)
        if @job_application.save
          render json: @job_application, status: :created
        end
        
        render json: { status: :bad_request, errors: @job_application.errors }, status: :bad_request
      end

      private

      def job_application_params
        params.require(:job_post_id)
      end
    end
  end
end
