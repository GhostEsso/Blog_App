require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Essohanam', photo: 'profile_picture', bio: 'User 1 called', post_counter: 0)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a blank name' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid with a non-integer post counter' do
    subject.post_counter = 'nuh'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative post counter' do
    subject.post_counter = -67
    expect(subject).to_not be_valid
  end

  it 'is not valid without a bio' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a photo link' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end
end
