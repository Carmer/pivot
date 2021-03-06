require 'rails_helper'

RSpec.describe "Users" do
  context "logged in as business" do
    it "can add jobs" do
      5.times do |x|
        User.create(id: x, name: "business", role: 1, username: "user#{x}", email: "user#{x}@example.com", password: "password", location: "Denver")
      end
      business_admin = create(:business_admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(business_admin)

      visit new_business_job_path(business: (User.find(business_admin.employer_id)).slug)

      fill_in "job[title]", with: "TestTitle"
      fill_in "job[description]", with: "TestDescription"
      click_link_or_button "Submit Job"

      expect(current_path).to eq(business_jobs_path(business: (User.find(business_admin.employer_id)).slug))
      expect(page).to have_content("TestTitle")
      expect(page).to have_content("TestDescription")
    end
  end
end
