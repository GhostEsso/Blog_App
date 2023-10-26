require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'should belong to an author' do
    user = User.create(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
    like = Like.new(user: user, post: nil) # Utilisez :user au lieu de :author_id, et post: nil pour cet exemple
    like.save

    association = Like.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    user = User.create(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
    post = Post.create(author: user, title: 'Eat me', text: 'You can fry and eat') # Utilisez :author au lieu de :author_id
    like = Like.new(user: nil, post: post) # Utilisez :post au lieu de :post_id, et user: nil pour cet exemple
    like.save

    association = Like.reflect_on_association(:post)
    expect(association.macro).to eq(:belongs_to)
  end
end
