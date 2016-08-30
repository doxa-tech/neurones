require 'rails_helper'

RSpec.describe "homepage", :type => :request do
  it "returns 200" do
    Page.create(name: "home", title: "Neurones", content: "Lorem Ipsum Dolorem")
    get "/"
    expect(response).to have_http_status(200)
  end
end
