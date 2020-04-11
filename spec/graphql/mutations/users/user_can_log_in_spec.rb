require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UserLogin, type: :request do
      describe 'user log in path' do
        it 'when credentials are correct' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user][:email]).to eq("carole@tigers.com")
          expect(result[:data][:user][:id]).to eq(user.id.to_s)
          expect(result[:data][:user].count).to eq(2)
        end
      end

      def query
        <<~GQL
        mutation {
          user: userLogin(
            input: {
              email: "carole@tigers.com"
              password: "password"
            }
          )
          {
            id
            email
          }
        }
        GQL
      end

      describe 'user login path' do
        it 'when password credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query1 }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user][:email]).to eq(nil)
        end
      end

      def query1
        <<~GQL
        mutation {
          user: userLogin(
            input: {
              email: "carole@tigers.com"
              password: "pass"
            }
          )
          {
            email
          }
        }
        GQL
      end

      describe 'user login path' do
        it 'when email credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query2 }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user][:email]).to eq(nil)
        end
      end

      def query2
        <<~GQL
        mutation {
          user: userLogin(
            input: {
              email: "carole@tigers"
              password: "password"
            }
          )
          {
            email
          }
        }
        GQL
      end

      describe 'user login path' do
        it 'when email credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query3 }
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user][:email]).to eq(nil)
        end
      end

      def query3
        <<~GQL
        mutation {
          user: userLogin(
            input: {
              email: "carole@tigers"
              password: "pass"
            }
          )
          {
            email
          }
        }
        GQL
      end
    end
  end
end
