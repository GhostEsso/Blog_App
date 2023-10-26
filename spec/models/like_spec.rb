require 'rails_helper'

RSpec.describe Like, type: :model do
  fixtures :users  # Charge les fixtures pour le modèle User

  it 'should belong to an author' do
    user = users(:user1)  # Utilisez la fixture user1
    like = Like.new(user: user, post: nil)
    like.save

    association = Like.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    user = users(:user1)
    post = Post.create(author: user, title: 'Eat me', text: 'You can fry and eat')
    like = Like.new(user: nil, post: post)
    like.save

    association = Like.reflect_on_association(:post)
    expect(association.macro).to eq(:belongs_to)
  end
end
