require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages/:id" do
    context "when the page exists" do
      let(:public_page) { create(:static_page, requires_sign_in: false) }
      let(:private_page) { create(:static_page, requires_sign_in: true) }

      context "for a public page" do
        it "returns http success" do
          get static_page_path(public_page)
          expect(response).to have_http_status(:success)
        end

        it "renders the page content" do
          get static_page_path(public_page)
          expect(response.body).to include(public_page.title)
        end
      end

      context "for a private page" do
        context "when user is not signed in" do
          it "redirects to sign in page" do
            get static_page_path(private_page)
            expect(response).to redirect_to(new_user_session_path)
          end
        end

        context "when user is signed in" do
          let(:user) { create(:user) }

          before do
            sign_in user
          end

          it "returns http success" do
            get static_page_path(private_page)
            expect(response).to have_http_status(:success)
          end

          it "renders the page content" do
            get static_page_path(private_page)
            expect(response.body).to include(private_page.title)
          end
        end
      end
    end

    context "when the page does not exist" do
      it "returns a 404 error" do
        get static_page_path(id: -999)

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("404")
      end
    end
  end

  describe "GET /static_pages" do
    let!(:static_pages) { create_list(:static_page, 3) }

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get static_pages_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "returns http success" do
        get static_pages_path
        expect(response).to have_http_status(:success)
      end

      it "renders the index template" do
        get static_pages_path
        expect(response.body).to include("Static Pages")
      end

      it "displays all static pages" do
        get static_pages_path
        static_pages.each do |page|
          expect(response.body).to include(page.title)
        end
      end
    end

    context "when admin is signed in" do
      let(:admin) { create(:user, :admin) }

      before do
        sign_in admin
      end

      it "returns http success" do
        get static_pages_path
        expect(response).to have_http_status(:success)
      end

      it "displays all static pages" do
        get static_pages_path
        static_pages.each do |page|
          expect(response.body).to include(page.title)
        end
      end
    end
  end
end
