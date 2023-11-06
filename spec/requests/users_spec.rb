# Include RSpec configuration for Rails
require 'rails_helper'

# Describe the test for the "Users" controller
RSpec.describe 'Users', type: :request do
  # Context for the "GET /index" test
  context 'GET /index' do
    before :each do
      # Perform an HTTP GET request to retrieve the list of users
      User.create(name: 'Tom')
      get users_path
    end

    # Check that the response is successful
    it 'returns a successful response' do
      expect(response).to be_successful
    end

    # Check that the HTTP status is 200
    it 'returns an HTTP status of 200' do
      expect(response.status).to eq(200)
    end

    # Check that the correct view is rendered
    it 'renders the correct view file' do
      expect(response).to render_template(:index)
    end

    # Check for the presence of an HTML tag in the response body
    it 'renders the correct placeholder' do
      expect(response.body).to include('<h2>Tom</h2>')
    end
  end

  # Context for the "GET /show" test
  context 'GET /show' do
    let(:valid_attributes) { { 'name' => 'Tom' } }
    let(:user) { User.create! valid_attributes }
    before :each do
      # Perform an HTTP GET request to display a specific user
      get user_url(user)
    end

    # Check that the response is successful
    it 'returns a successful response' do
      expect(response).to be_successful
    end

    # Check that the HTTP status is 200
    it 'returns an HTTP status of 200' do
      expect(response.status).to eq(200)
    end

    # Check that the correct view is rendered
    it 'renders the correct view file' do
      expect(response).to render_template(:show)
    end

    # Check for the presence of an HTML tag in the response body
    it 'renders the correct placeholder' do
      expect(response.body).to include('<h2>Tom</h2>')
      expect(response.body).to include('<p>Number of posts: 0</p>')
      expect(response.body).to include('<h3>Bio</h3>')
    end
  end
end
