require 'rails_helper'

RSpec.describe 'When I open user index page', type: :system do
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
    Post.create(author: @first_user, title: 'Title')
    Post.create(author: @first_user, title: 'Title')
    Post.create(author: @second_user, title: 'Title')
  end

  it 'should have 3 users' do
    visit users_path
    sleep(1)

    expect(page.all('ul#users_container li').size).to eq(3)
  end

  it 'shows the username of all other users' do
    visit users_path
    sleep(1)

    expect(page).to have_text(@first_user.name)
    expect(page).to have_text(@second_user.name)
    expect(page).to have_text(@third_user.name)
  end

  it 'shows the profile picture for each user' do
    visit users_path
    sleep(1)

    expect(page).to have_css("img[src='#{@first_user.photo}']")
    expect(page).to have_css("img[src='#{@second_user.photo}']")
    expect(page).to have_css("img[src='#{@third_user.photo}']")
  end

  it 'shows the number of posts each user has written' do
    visit users_path
    sleep(1)

    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 0')
  end

  context 'When I click on a user' do
    it "redirects to first user's show page" do
      visit users_path
      sleep(1)
      click_link(@first_user.name)
      sleep(1)
      expect(page).to have_current_path(user_path(@first_user))
    end

    it "redirects to second user's show page" do
      visit users_path
      sleep(1)
      click_link(@second_user.name)
      sleep(1)
      expect(page).to have_current_path(user_path(@second_user))
    end

    it "redirects to third user's show page" do
      visit users_path
      sleep(1)
      click_link(@third_user.name)
      sleep(1)
      expect(page).to have_current_path(user_path(@third_user))
    end
  end
end
