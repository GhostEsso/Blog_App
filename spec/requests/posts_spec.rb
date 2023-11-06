# Include RSpec configuration for Rails
require 'rails_helper'

# Describe the test for the "Posts" controller
RSpec.describe 'Posts', type: :request do
  # Context for the "GET /index" test
  context 'GET /index' do
    let(:user) { User.create(name: 'Tom') }
    before :each do
      # Perform an HTTP GET request to retrieve the list of posts for a user
      Post.create(author: user, title: 'Title')
      get user_posts_path(user)
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
      expect(response.body).to include('<p>Number of posts: 1</p>')
      expect(response.body).to include('<h3>Title</h3>')
      expect(response.body).to include('<p></p>')
      expect(response.body).to include(`<p class="counter">\nComments: 0, Likes: 0\n</p>`)
    end
  end

  # Context for the "GET /show" test
  context 'GET /show' do
    let(:user) { User.create(name: 'Tom') }
    let(:valid_attributes) { { 'author' => user, 'title' => 'Title' } }
    let(:post) { Post.create! valid_attributes }

    before :each do
      # Perform an HTTP GET request to display a specific post for a user
      get "/users/:user_id/posts/#{post.id}"
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
      expect(response.body).to include('<h3>Title by Tom</h3>')
      expect(response.body).to include('<p></p>')
      expect(response.body).to include(`<p class="counter">\nComments: 0, Likes: 0\n</p>`)
    end
  end
end
