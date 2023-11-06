require 'rails_helper'

RSpec.describe 'When I open user show page', type: :system do
  before :all do
    Like.delete_all
    Comment.delete_all
    Post.delete_all
    User.delete_all
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Poland.')
    @third_user = User.create(name: 'Alan', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Singer from Mexico.')
    @latest_post = Post.create(author: @first_user, title: 'Latest Post', text: 'This is my latest post')

    @index = 1
    (1..3).each do
      Comment.create(post: @latest_post, user: @second_user, text: "Comment ##{@index}")
      @index += 1
      Comment.create(post: @latest_post, user: @third_user, text: "Comment ##{@index}")
      @index += 1
    end

    10.times { Like.create(post: @latest_post, user: @third_user) }
    10.times { Like.create(post: @latest_post, user: @second_user) }
  end

  it "shows the post's title" do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_content('Latest Post')
  end

  it 'shows who wrote the post' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_content('by Tom')
  end

  it 'shows how many comments it has' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_content('Comments: 6')
  end

  it 'shows how many likes it has' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_content('Likes: 20')
  end

  it 'shows the post body' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_content('This is my latest post')
  end

  it 'shows the username of each commentor' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    expect(page).to have_text('Lilly:', count: 3)
    expect(page).to have_text('Alan:', count: 3)
  end

  it 'shows the comment each commentor left' do
    visit user_post_path(@first_user, @latest_post)
    sleep(1)
    (1..6).each do |i|
      expect(page).to have_content("Comment ##{i}")
    end
  end
end
