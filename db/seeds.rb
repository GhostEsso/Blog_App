# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

first_user = User.create(name: 'Tom', bio: 'Teacher from Mexico.', email: 'tom@example.com', :password => 'topsecret', :password_confirmation => 'topsecret')
second_user = User.create(name: 'Lilly', bio: 'Teacher from Poland.', email: 'lilly@example.com', :password => 'topsecret', :password_confirmation => 'topsecret')
third_user = User.create(name: 'Alan', bio: 'Singer from Mexico.', email: 'alan@example.com', :password => 'topsecret', :password_confirmation => 'topsecret')
fourth_user = User.create(name: 'Alan', bio: 'Singer from Mexico.', email: 'alan2@example.com', :password => 'topsecret', :password_confirmation => 'topsecret')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'My name is Tom', text: 'This is my second post')
third_post = Post.create(author: first_user, title: 'I am a techer', text: 'This is my third post')
fourth_post = Post.create(author: first_user, title: 'I am from Mexico', text: 'This is my fourth post')
fivth_post = Post.create(author: second_user, title: 'I am from England', text: "This is another person's post")
Comment.create(post: first_post, user: second_user, text: 'Hi Tom!')
Comment.create(post: first_post, user: second_user, text: 'Nice to meet you!')
Comment.create(post: first_post, user: second_user, text: "I'm a teacher too!")
Comment.create(post: first_post, user: third_user, text: 'Hello Tom!')
Comment.create(post: first_post, user: third_user, text: 'Glad to meet you!')
Comment.create(post: first_post, user: third_user, text: "I'm from Mexico too!")
