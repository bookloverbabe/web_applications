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
      response = get('/hello?name=Josh')

      expect(response.status).to eq(200)
      expect(response.body).to eq('Hello Josh')
    end
  end
end