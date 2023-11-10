require 'rails_helper'

RSpec.describe Like, type: :model do
  before :all do
    @user = User.create(name: 'Lilly', email: 'lilly@example.com', password: 'topsecret')
    @post = Post.create(author: @user, title: 'Title')
  end

  context '#create' do
    it 'is valid with existing user and post' do
      expect(Like.new(user: @user, post: @post)).to be_valid
    end

    it 'is not valid without post' do
      expect(Like.new(user: @user)).to_not be_valid
    end

    it 'is not valid without user' do
      expect(Like.new(post: @post)).to_not be_valid
    end
  end

  context '#update_likes_counter' do
    before :all do
      @user1 = User.create(name: 'Alan', email: 'alan@example.com',
                           password: 'topsecret')
      2.times { Like.create(user: @user, post: @post) }
      3.times { Like.create(user: @user1, post: @post) }
    end

    it 'keeps track of likes and equals 8' do
      expect(@post.likes_counter).to eq 2
    end
  end
end
