require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UserLogin, type: :request do
      describe 'user log in path' do
        it 'when credentials are correct' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query}, headers: { 'Authorization' => ""}

          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user][:token].length).to eq(72)
          expect(result[:data][:user][:user][:id]).to eq(user.id.to_s)
          expect(result[:data][:user].count).to eq(2)
        end
      end

      def query
        <<~GQL
        mutation {
          user: userLogin(
            input: {
               credentials: {
                email: "carole@tigers.com"
                password: "password"
              }
            }
          )
          {
            token
              user {
                id
              }
            }
          }
        GQL
      end

      describe 'user login path' do
        it 'when password credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query1 }, headers: { 'Authorization' => ""}
          result = JSON.parse(response.body, symbolize_names: true)
          expect(result[:data][:user]).to eq(nil)
        end
      end

      def query1
        <<~GQL
        mutation {
          user: userLogin(
            input: {
               credentials: {
                email: "carole@tigers.com"
                password: "passwd"
              }
            }
          )
          {
            token
              user {
                id
              }
            }
          }
        GQL
      end

      describe 'user login path' do
        it 'when email credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query2 }, headers: { 'Authorization' => ""}
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user]).to eq(nil)
        end
      end

      def query2
        <<~GQL
        mutation {
          user: userLogin(
            input: {
               credentials: {
                email: "carole@tigers"
                password: "password"
              }
            }
          )
          {
            token
              user {
                id
              }
            }
          }
        GQL
      end

      describe 'user login path' do
        it 'when email credentials are incorrect' do
          user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)

          post "/graphql", params: { query: query3 }, headers: { 'Authorization' => ""}
          result = JSON.parse(response.body, symbolize_names: true)

          expect(result[:data][:user]).to eq(nil)
        end
      end

      def query3
        <<~GQL
        mutation {
          user: userLogin(
            input: {
               credentials: {
                email: "carole@tigers"
                password: "password"
              }
            }
          )
          {
            token
              user {
                id
              }
            }
          }
        GQL
      end
    end
  end
end
