module Api
  module V1
    class Posts < Grape::API
      resource :posts do
        desc 'Create a post with random content'
        post '/' do
          title = TitleProviderClient.client.get_title
          content = Forgery('lorem_ipsum').paragraph

          Post.create!({title: title, content: content})
        end

        desc 'Retrieve all posts'
        get '/' do
          Post.all
        end
      end
    end
  end
end
