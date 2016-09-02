class Post < ActiveRecord::Base
    belongs_to :user
    acts_as_votable

    def self.search(search)
      if search
        where(["content LIKE ?","%#{search}%"])
      else
        all
     end
    end 
  end