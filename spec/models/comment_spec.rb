require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should belong to an author' do
    user = User.create(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
    post = Post.create(author: user, title: 'Eat me', text: 'You can fry and eat')
    comment = Comment.new(author: user, post: post, text: 'Nice buddy')
    
    expect(comment).to be_valid
  end

  it 'should belong to a post' do
    user = User.create(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
    post = Post.create(author: user, title: 'Eat me', text: 'You can fry and eat')
    comment = Comment.new(author: user, post: post, text: 'Nice buddy')
    
    expect(comment).to be_valid
  end

  it 'can have text' do
    user = User.create(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
    post = Post.create(author: user, title: 'Eat me', text: 'You can fry and eat')
    comment = Comment.new(author: user, post: post, text: 'Nice buddy')
    
    expect(comment.text).to eq('Nice buddy')
  end
end
