require 'rails_helper'
require_relative '../support/devise_request_login'

RSpec.describe Api::V1::JobApplicationsController, type: :request do
  describe 'GET index' do
    context 'when no user is logged in' do
      it 'returns forbidden' do
        get '/api/v1/job_applications'
        expect(response.status).to eq(403)
      end
    end

    context 'when a normal user is logged in' do
      it 'returns forbidden' do
        headers = login_user
        get '/api/v1/job_applications', headers: headers
        expect(response.status).to eq(403)
      end
    end

    context 'when an admin is logged in' do
      it 'returns valid data' do
        headers = login_admin
        get '/api/v1/job_applications', headers: headers
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET show' do
    context 'when no user is logged in' do
      it 'returns forbidden' do
        job_application = FactoryBot.create(:job_application)
        get "/api/v1/job_applications/#{job_application.id}"
        expect(response.status).to eq(403)
      end
    end

    context 'when a normal user is logged in' do
      it 'returns forbidden if the current user did not create the job application' do
        # TODO fix 'email has already been taken' error, probably an issue with the factory
        headers = login_user
        job_application = FactoryBot.create(:job_application)
        get "/api/v1/job_applications/#{job_application.id}", headers: headers
        expect(response.status).to eq(403)
      end

      it 'returns data if the current user created the job application' do
        user = FactoryBot.create(:user)
        headers = login_user(user)
        job_application = FactoryBot.create(:job_application, user: user)
        get "/api/v1/job_applications/#{job_application.id}", headers: headers
        expect(response.status).to eq(200)
      end
    end
  end
end
