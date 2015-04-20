class Goal < ActiveRecord::Base
  belongs_to :user

  validates :title, :user_id, presence: true

  has_many :comments, class_name: "GoalComment", dependent: :destroy

end
