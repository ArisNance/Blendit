class Story < ActiveRecord::Base
    belongs_to :user
    acts_as_votable
end
def content
  self[:content].html_safe if self[:content]
end

# def self.search(search)
# if search
#     where(["content LIKE ?","%#{search}%"])
#   else
#     all
# end
# end 