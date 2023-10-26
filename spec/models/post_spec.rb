require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Essohanam', photo: 'link', bio: 'User 1 called', post_counter: 0) }
  subject do
    Post.new(author: user, title: 'Eat me', text: 'You can fry and eat')
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a blank title' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid with a too long title' do
    subject.title = 'A' * 251 # Exceeds the maximum length of 250 characters
    expect(subject).to_not be_valid
  end

  it 'has a positive comments counter' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'has a positive likes counter' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'has a valid author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end
end
