# frozen_string_literal: true

# Helpers that get automatically included in feature specs.
module Decidim::FeatureTestHelpers
  def click_submenu_link(text)
    within ".secondary-nav--subnav" do
      click_link text
    end
  end

  def within_user_menu
    within ".topbar__user__logged" do
      find("a", text: user.name).hover
      yield
    end
  end

  def within_language_menu
    within ".topbar__dropmenu.language-choose" do
      find("ul.dropdown.menu").hover
      yield
    end
  end

  def stripped(text)
    Nokogiri::HTML(text).text
  end

  def within_flash_messages
    within ".flash" do
      yield
    end
  end

  def expect_user_logged
    expect(page).to have_css(".topbar__user__logged")
  end

  def have_admin_callout(text)
    have_selector(".callout--full", text: text)
  end
end

RSpec.configure do |config|
  config.include Decidim::FeatureTestHelpers, type: :feature
end
