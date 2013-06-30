require 'spec_helper'

describe "Story pages" do

  subject { page }

	describe "index" do

    describe "pagination" do

      stories = []
      before(:all) { 30.times { stories << FactoryGirl.create(:story) } }
      after(:all) { stories.each { |s| s.destroy } }
      
      before { visit stories_path }

      it { should have_selector('div.pagination') }

      it "should list each story" do
        Story.paginate(page: 1, per_page:10, order: :title).each do |story|
          story.should have_selector('h3', text: story.title)
        end
      end
    end
		
		describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit stories_path
        end

        it { should have_link(href: story_path(Story.find(:all, order: :title).first)) }
        it "should be able to delete another user's story" do
          expect { click_link('delete') }.to change(Story, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
	
  describe "show" do
    story = Story.first
    before { visit story_path(story) }

    it { should have_selector('h1',    text: story.title) }
    it { should have_selector('title', text: full_title(story.title)) }
    it { should have_content(story.description) }
  end
	
	describe "edit" do
    let(:story) { Story.first }

    before {

      sign_in story.user

      visit edit_story_path(story)
    }

    it { should have_content("Update #{story.title}") }
    it { should have_content("Edit story") }
  end
end