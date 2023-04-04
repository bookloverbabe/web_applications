# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /hello' do
    it 'should return "Hello Leo"' do
      response = get('/hello?name=Leo')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello Leo')
    end

    it 'should return "Hello Josh"' do
      # ? used in get request, as a query request
      response = get('/hello?name=Josh')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello Josh')
    end
  end

  context 'GET /names' do
    it 'should return names' do
      response = get('/names')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Julia, Mary, Karim')
    end
  end

  context 'POST /sort-names' do
    it 'should return sort_names' do
      # For post pass in body parameters, so don't need ? like in above
      response = post("/sort-names", names: "Joe, Alice, Zoe, Julia, Kieran")

      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice, Joe, Julia, Kieran, Zoe')
    end

    it 'should return sort_names' do
      response = post("/sort-names", names: "Joe, Alice, Zoe, Julia")

      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice, Joe, Julia, Zoe')
    end
  end
end