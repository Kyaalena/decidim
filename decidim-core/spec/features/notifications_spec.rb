# frozen_string_literal: true

require "spec_helper"

describe "Notifications", type: :feature do
  let(:resource) { create :dummy_resource }
  let(:participatory_space) { resource.feature.participatory_space }
  let(:organization) { participatory_space.organization }
  let!(:user) { create :user, :confirmed, organization: organization }
  let!(:notification) { create :notification, user: user, resource: resource }

  before do
    switch_to_host organization.host
    login_as user, scope: :user
    page.visit decidim.notifications_path
  end

  context "listing notifications" do
    context "when no notification is found" do
      let!(:notification) { nil }

      it "doesn't show any notification" do
        expect(page).to have_content("No notifications yet")
      end
    end

    context "with notifications" do
      it "shows the notifications" do
        expect(page).to have_selector("section#notifications-list .card--list__item")
      end
    end
  end
end
