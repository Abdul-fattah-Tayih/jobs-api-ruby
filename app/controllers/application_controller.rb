class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: { status: :forbidden, message: exception.message }, status: :forbidden }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.json { render json: { status: 404, message: "Can't find resource with the id #{params[:id]}" }, status: :not_found }
    end
  end
end
