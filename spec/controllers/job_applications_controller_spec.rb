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

    context 'when a an admin is logged in' do
      it 'returns data' do
        headers = login_admin
        job_application = FactoryBot.create(:job_application)
        get "/api/v1/job_applications/#{job_application.id}", headers: headers
        expect(response.status).to eq(200)
      end

      it 'changes the seen value to true' do
        headers = login_admin
        job_application = FactoryBot.create(:job_application)
        get "/api/v1/job_applications/#{job_application.id}", headers: headers
        expect(JobApplication.first.seen).to eq(true)
      end
    end
  end

  describe 'POST create' do
    context 'no user is logged in' do
      it 'returns forbidden' do
        job_application_data = FactoryBot.build(:job_application)
        post '/api/v1/job_applications', params: job_application_data.serializable_hash
        expect(response.status).to eq(403)
      end
    end

    context 'a normal user is logged in' do
      it 'creates the job application successfully' do
        user = FactoryBot.create(:user)
        headers = login_user(user)
        job_application_data = FactoryBot.build(:job_application, user: user)
        post '/api/v1/job_applications', params: job_application_data.serializable_hash, headers: headers
        expect(response.status).to eq(201)
        expect(JobApplication.count).to eq(1)

        db_job_application = JobApplication.first
        expect(db_job_application.user_id).to eq(user.id)
        expect(db_job_application.job_post_id).to eq(job_application_data.job_post_id)
      end
    end

    context 'when an admin is logged in' do
      it 'returns forbidden' do
        headers = login_admin
        job_application_data = FactoryBot.build(:job_application)
        post '/api/v1/job_applications', params: job_application_data.serializable_hash, headers: headers
        expect(response.status).to eq(403)
      end
    end
  end
end
