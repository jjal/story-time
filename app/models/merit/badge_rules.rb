# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+:votes => 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    include Merit::BadgeRulesMethods

    def initialize
      # If it creates user, grant badge
      # Should be "current_user" after registration for badge to be granted.
      # grant_on 'users#create', :badge => 'just-registered', :to => :itself

      grant_on ['pages#create','pages#update'], :badge => 'words', :level=>1 do |page|
        deserves = page.story.user.stories.collect{ |s| s.get_word_count }.sum > 2000
        page.story.user.clear_badges('words',1) if(deserves)
        deserves
      end

      grant_on ['pages#create','pages#update'], :badge => 'words', :level=>2 do |page|
        deserves = page.story.user.stories.collect{ |s| s.get_word_count }.sum > 4000  
        page.story.user.clear_badges('words',2) if(deserves)
        deserves
      end

      grant_on ['pages#create','pages#update'], :badge => 'words', :level=>3 do |page|
        deserves = page.story.user.stories.collect{ |s| s.get_word_count }.sum > 6000
        page.story.user.clear_badges('words',3) if(deserves)
        deserves
      end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', :badge => 'relevant-commenter', :to => :user do |comment|
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', :badge => 'autobiographer', :temporary => true, :model_name => 'User' do |user|
      #   user.name.length > 4
      # end
    end
  end
end
