# frozen_string_literal: true

require "spec_helper"

describe Decidim::Surveys::Abilities::ParticipatoryProcessAdminAbility do
  subject { described_class.new(user, context) }

  let(:user) { build(:user) }
  let(:user_process) { create :participatory_process, organization: user.organization }
  let!(:user_role) { create :participatory_process_user_role, user: user, participatory_process: user_process, role: :admin }
  let(:context) { { current_participatory_process: user_process } }

  context "when the user is an admin" do
    let(:user) { build(:user, :admin) }

    it "doesn't have any permission" do
      expect(subject.permissions[:can]).to be_empty
      expect(subject.permissions[:cannot]).to be_empty
    end
  end

  it { is_expected.to be_able_to(:manage, Decidim::Surveys::Survey) }
  it { is_expected.to be_able_to(:answer, Decidim::Surveys::Survey) }
end
