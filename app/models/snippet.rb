class Snippet < ActiveRecord::Base
   attr_accessible :title, :snippet, :language, :user, :public
   belongs_to :user

   def self.by_owner_or_public(user_id)
     where('user_id = ? or public = ?',user_id,true)
   end
end
