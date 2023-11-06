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
    Post.create(author: @first_user, title: 'Post1')
    Post.create(author: @first_user, title: 'Post2')
    Post.create(author: @first_user, title: 'Post3')
    @latest_post = Post.create(author: @first_user, title: 'Post4')
    Post.create(author: @second_user, title: 'Post1')
    Post.create(author: @second_user, title: 'Post2')
  end

  it "shows the user's profile picture" do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_css("img[src='#{@first_user.photo}']")
    visit users_path
    sleep(1)
    click_link(@second_user.name)
    sleep(1)
    expect(page).to have_css("img[src='#{@second_user.photo}']")
    visit users_path
    sleep(1)
    click_link(@third_user.name)
    sleep(1)
    expect(page).to have_css("img[src='#{@third_user.photo}']")
  end

  it "shows the user's username" do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_content('Tom')
    visit users_path
    sleep(1)
    click_link(@second_user.name)
    sleep(1)
    expect(page).to have_content('Lilly')
    visit users_path
    sleep(1)
    click_link(@third_user.name)
    sleep(1)
    expect(page).to have_content('Alan')
  end

  it 'shows the number of posts the user has written' do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_content('Number of posts: 4')
    visit users_path
    sleep(1)
    click_link(@second_user.name)
    sleep(1)
    expect(page).to have_content('Number of posts: 2')
    visit users_path
    sleep(1)
    click_link(@third_user.name)
    sleep(1)
    expect(page).to have_content('Number of posts: 0')
  end

  it "shows the user's bio" do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_content('Teacher from Mexico.')
    visit users_path
    sleep(1)
    click_link(@second_user.name)
    sleep(1)
    expect(page).to have_content('Teacher from Poland.')
    visit users_path
    sleep(1)
    click_link(@third_user.name)
    sleep(1)
    expect(page).to have_content('Singer from Mexico.')
  end

  it "shows the user's latest 3 posts" do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_content('Post4')
    expect(page).to have_content('Post3')
    expect(page).to have_content('Post2')
  end

  it "shows a button that lets me view all of a user's posts" do
    visit users_path
    sleep(1)
    click_link(@first_user.name)
    sleep(1)
    expect(page).to have_link('See all posts', href: "/users/#{@first_user.id}/posts?page=1")
  end

  context "When I click a user's post" do
    it "redirects me to that post's show page" do
      visit users_path
      sleep(1)
      click_link(@first_user.name)
      sleep(1)
      click_link('Post4')
      sleep(1)
      expect(page).to have_current_path(user_post_path(@first_user, @latest_post))
    end
  end

  context 'When I click to see all posts' do
    it "redirects me to the user's post's index page" do
      visit users_path
      sleep(1)
      click_link(@first_user.name)
      sleep(1)
      click_link('See all posts')
      sleep(1)
      expect(page).to have_current_path("/users/#{@first_user.id}/posts?page=1")
    end
  end
end
