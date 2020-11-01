require 'rails_helper'
require_relative '../support/devise_request_login'

RSpec.describe Api::V1::JobPostsController, type: :request do
  describe 'GET index' do
    it 'returns a successful response' do
      get '/api/v1/job_posts'
      expect(response).to be_successful
    end

    it 'should list all job posts' do
      create_list(:job_post, 5)
      get '/api/v1/job_posts'
      json = JSON.parse(response.body)
      expect(json.count).to eq(5)
    end
  end

  describe 'GET show' do
    before do
      @job_post = create(:job_post)
      get "/api/v1/job_posts/#{@job_post.id}"
    end
    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'returns correct data' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@job_post.id)
      expect(json['title']).to eq(@job_post.title)
      expect(json['description']).to eq(@job_post.description)
    end
  end

  describe 'POST create' do
    context 'when user is not logged in' do
      it 'returns forbidden' do
        post '/api/v1/job_posts', params: FactoryBot.build(:job_post).serializable_hash, headers: { format: :json }
        expect(response.status).to eq(403)
      end
    end

    context 'when a normal user is logged in' do
      it 'returns forbidden' do
        headers = login_user
        post '/api/v1/job_posts', params: FactoryBot.build(:job_post).serializable_hash, headers: headers
        expect(response.status).to eq(403)
      end
    end

    context 'when an admin is logged in' do
      it 'is created with valid data' do
        headers = login_admin
        post '/api/v1/job_posts', params: FactoryBot.build(:job_post).serializable_hash, headers: headers
        expect(response.status).to eq(201)
        expect(JobPost.count).to eq(1)
      end
    end
  end

  describe 'PATCH update' do
    context 'when user is not logged in' do
      it 'returns forbidden' do
        job_post = FactoryBot.create(:job_post)
        patch "/api/v1/job_posts/#{job_post.id}", params: FactoryBot.build(:job_post).serializable_hash, headers: { format: :json }
        expect(response.status).to eq(403)
      end
    end
    context 'when a normal user is logged in' do
      it 'returns forbidden' do
        headers = login_user
        job_post = FactoryBot.create(:job_post)
        patch "/api/v1/job_posts/#{job_post.id}", params: FactoryBot.build(:job_post).serializable_hash, headers: headers
        expect(response.status).to eq(403)
      end
    end

    context 'when an admin is logged in' do
      it 'is created with valid data' do
        headers = login_admin
        job_post = FactoryBot.create(:job_post)
        updated_job_post_data = FactoryBot.build(:job_post)
        patch "/api/v1/job_posts/#{job_post.id}", params: updated_job_post_data.serializable_hash, headers: headers
        expect(response.status).to eq(200)
        expect(JobPost.count).to eq(1)
        expect(JobPost.first.title).to eq(updated_job_post_data.title)
        expect(JobPost.first.description).to eq(updated_job_post_data.description)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when user is not logged in' do
      it 'returns forbidden' do
        job_post = FactoryBot.create(:job_post)
        delete "/api/v1/job_posts/#{job_post.id}", headers: { format: :json }
        expect(response.status).to eq(403)
      end
    end
    context 'when a normal user is logged in' do
      it 'returns forbidden' do
        headers = login_user
        job_post = FactoryBot.create(:job_post)
        delete "/api/v1/job_posts/#{job_post.id}", headers: headers
        expect(response.status).to eq(403)
      end
    end

    context 'when an admin is logged in' do
      it 'is created with valid data' do
        headers = login_admin
        job_post = FactoryBot.create(:job_post)
        delete "/api/v1/job_posts/#{job_post.id}", headers: headers
        expect(response.status).to eq(204)
        expect(JobPost.count).to eq(0)
      end
    end
  end
end
