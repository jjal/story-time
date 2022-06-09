require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector 'title', text: '| Home' }
		
		describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end
      it { should_not have_selector 'a', text: 'Sign in' }
    end
  end

  describe "Help page" do
    let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit help_path 
      end
 
    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }
    
    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end