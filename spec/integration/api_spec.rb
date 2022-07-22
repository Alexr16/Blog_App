require 'swagger_helper'

describe 'API' do

  path '/api/v1/users' do

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'name', 'status' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Jorge', status: :ok } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}/posts' do

    get 'Retrieves posts for a user' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Users posts' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            email: { type: :string },
            password: { type: :string }
          },
          required: [ 'id', 'name', 'status' ]

        let(:id) { User.create(name: 'Chris', photo: 'https://i.stack.imgur.com/YQu5k.png', bio: 'Hello world', email: 'jorge@icloud.com', password: '123456', role: 'admin').id }
        run_test!
      end

      response '404', 'User not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end