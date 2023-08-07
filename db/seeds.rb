# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create a Sports topic
sports_topic = Topic.create(name: 'Sports')

# Create a post inside Sports topic
sports_post = sports_topic.posts.create(title: 'Football', content: 'This is a football post.')

# You can add more posts to the Sports topic if needed
