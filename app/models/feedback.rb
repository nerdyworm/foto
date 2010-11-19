class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :comment
  
  field :email
  field :username

  field :voters, :type => Array
  field :votes,  :type => Integer, :default => 0

  referenced_in :picture
  referenced_in :user
  
  class << self
    def vote(feedback_id, user_id, direction)
      feedback_id = BSON::ObjectId(feedback_id) if feedback_id.class == String
      user_id  = BSON::ObjectId(user_id) if user_id == String

      collection.update(
        { '_id' => feedback_id, 'voters' => {'$ne' => user_id}}, 
        { '$inc' => {'votes' => direction},'$push' => {'voters' => user_id}})
    end

    def downvote(id, user_id)
      self.vote(id, user_id, -1)
    end

    def upvote(id, user_id)
      self.vote(id, user_id, 1)
    end
  end
end
