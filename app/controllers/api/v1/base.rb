module Api
  module V1
    class Base < Grape::API
      format :json
      version 'v1'
      content_type :json, 'application/json'

      mount Api::V1::Posts
    end
  end
end
