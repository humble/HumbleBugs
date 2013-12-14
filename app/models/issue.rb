class Issue < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :game, :inverse_of => :issues, :touch => true
  belongs_to :reported_against, :class_name => 'Release', :inverse_of => :reported_issues
  belongs_to :fixed_in, :class_name => 'Release', :inverse_of => :fixed_issues
  has_many :comments, :as => :commentable, :inverse_of => :commentable, :dependent => :destroy, :order => 'comments.created_at ASC'

  acts_as_taggable_on :platforms

  STATUSES = [
      ['New', :new],
      ['Waiting on Tester Feedback', :feedback],
      ['Waiting on Developer', :active],
      ['Won\'t fix', :suspended],
      ['Duplicate', :duplicate],
      ['Invalid', :invalid],
      ['Fixed', :completed]
  ]

  validates_presence_of :status, :description, :summary, :game_id, :author_id
  validates_inclusion_of :status, :in => STATUSES.map { |m| m.second.to_s }, :message => "%{value} is not a valid status"
end
