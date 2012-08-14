class Issue < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :game, :inverse_of => :issues
  belongs_to :reported_against, :class_name => 'Release', :inverse_of => :reported_issues
  belongs_to :fixed_in, :class_name => 'Release', :inverse_of => :fixed_issues
  has_many :comments, :as => :commentable, :inverse_of => :commentable

  acts_as_taggable_on :platforms

  STATUSES = [
      ['New', :new],
      ['Waiting Feedback', :feedback],
      ['Active', :active],
      ['Suspended', :suspended],
      ['Resolved', :completed]
  ]

  validates_presence_of :status, :description, :game_id, :author_id
  validates_inclusion_of :status, :in => STATUSES.map { |m| m.second.to_s }, :message => "%{value} is not a valid status"

  def summary
    ActionController::Base.helpers.truncate(description, length: 50)
  end
end
