require 'rails_helper'

RSpec.describe User, type: :model do
  context '#create validates required fields' do
    it 'is valid with existing name, email and password' do
      expect(User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')).to be_valid
    end

    it 'is not valid with blank name' do
      expect(User.create(email: 'tom@example.com', password: 'topsecret')).to_not be_valid
    end

    it 'is not valid with blank email' do
      expect(User.create(name: nil, password: 'topsecret')).to_not be_valid
    end

    it 'is not valid with blank password' do
      expect(User.create(name: nil, email: 'tom@example.com')).to_not be_valid
    end
  end

  context '#create validates posts_counter data type' do
    it 'is not valid with non-numeric posts_counter' do
      expect(User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret',
                         posts_counter: 'five')).to_not be_valid
    end

    it 'is not valid with float posts_counter' do
      expect(User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret',
                         posts_counter: 1.5)).to_not be_valid
    end

    it 'is not valid with negative posts_counter' do
      expect(User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret',
                         posts_counter: -1)).to_not be_valid
    end

    it 'is valid with integer posts_counter' do
      expect(User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret', posts_counter: 5)).to be_valid
    end
  end

  context '#three_recent_posts' do
    before :all do
      @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
      5.times { |post_i| Post.create(author: @user, title: (post_i + 1).to_s) }
    end

    it 'returns three posts' do
      expect(@user.three_recent_posts.length).to eq 3
    end

    it 'returns most recent posts with titles 3, 4, 5' do
      titles = []
      @user.three_recent_posts.each do |post|
        titles.push(post.title.to_i)
      end
      expect(titles).to all(be_between(3, 5))
    end
  end
end
