require "rails_helper"

RSpec.describe "Routes", type: :routing do
  describe "Basic routes" do
    it "routes root to home#show" do
      expect(get: "/").to route_to(controller: "home", action: "show")
    end

    it "routes /home to home#show" do
      expect(get: "/home").to route_to(controller: "home", action: "show")
    end

    it "routes /up to rails/health#show" do
      expect(get: "/up").to route_to(controller: "rails/health", action: "show")
    end

    it "routes /static_pages/:id to static_pages#show" do
      expect(get: "/static_pages/1").to route_to(controller: "static_pages", action: "show", id: "1")
    end
  end

  describe "Devise routes" do
    it "routes /users/sign_in to devise/sessions#new" do
      expect(get: "/users/sign_in").to route_to(controller: "devise/sessions", action: "new")
    end

    it "routes /users/sign_out to devise/sessions#destroy" do
      expect(delete: "/users/sign_out").to route_to(controller: "devise/sessions", action: "destroy")
    end

    it "routes /users/password/new to devise/passwords#new" do
      expect(get: "/users/password/new").to route_to(controller: "devise/passwords", action: "new")
    end

    it "routes /users/password to devise/passwords#create" do
      expect(post: "/users/password").to route_to(controller: "devise/passwords", action: "create")
    end

    it "routes /users/password/edit to devise/passwords#edit" do
      expect(get: "/users/password/edit").to route_to(controller: "devise/passwords", action: "edit")
    end

    it "routes /users/password to devise/passwords#update" do
      expect(patch: "/users/password").to route_to(controller: "devise/passwords", action: "update")
    end

    it "routes /users/sign_up to devise/registrations#new" do
      expect(get: "/users/sign_up").to route_to(controller: "devise/registrations", action: "new")
    end

    it "routes /users to devise/registrations#create" do
      expect(post: "/users").to route_to(controller: "devise/registrations", action: "create")
    end

    it "routes /users/edit to devise/registrations#edit" do
      expect(get: "/users/edit").to route_to(controller: "devise/registrations", action: "edit")
    end

    it "routes /users to devise/registrations#update" do
      expect(patch: "/users").to route_to(controller: "devise/registrations", action: "update")
    end

    it "routes /users to devise/registrations#destroy" do
      expect(delete: "/users").to route_to(controller: "devise/registrations", action: "destroy")
    end
  end
end
