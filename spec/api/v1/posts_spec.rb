describe Api::V1::Posts do
  describe 'GET /posts' do
    context 'when there is no persisted posts' do
      it 'returns an empty array' do
        get '/api/v1/posts'

        expect(response.code).to eq("200")
        expect(response.body).to eq([].to_json)
      end
    end

    context 'when there are persisted posts' do
      before do
        3.times do |i|
          Post.create(title: "Title #{i}", content: "Lorem ipsum #{i}")
        end
      end

      it 'returns an array of posts' do
        get '/api/v1/posts'
        parsed_response = JSON.parse(response.body)

        expect(response.code).to eq("200")
        expect(parsed_response).to be_a(Array)
        expect(parsed_response.length).to eq(3)
      end
    end
  end

  describe 'POST /posts' do

    before(:all) do
      @words = "this is my generated words"
      stub_request(:get, 'http://localhost:9292/api/words')
        .to_return(status: 200, body: { words: @words }.to_json)
    end

    it 'creates a new post' do
      post '/api/v1/posts'

      expect(response.code).to eq("201")
      expect(JSON.parse(response.body)["title"]).to eq(@words)
    end
  end
end
