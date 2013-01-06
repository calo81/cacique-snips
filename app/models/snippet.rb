class Snippet < ActiveRecord::Base
   attr_accessible :title, :snippet, :language, :user
   belongs_to :user
end
