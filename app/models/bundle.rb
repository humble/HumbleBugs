class Bundle < ActiveRecord::Base
  has_many :games, :inverse_of => :bundle, :dependent => :nullify, :order => 'games.name ASC'
  has_many :issues, :through => :games, :order => 'issues.updated_at DESC'

  STATES = Types::Bundle::STATES

  validates_presence_of :name, :state, :description
  validates_inclusion_of :state, :in => STATES.map { |m| m.second.to_s }, :message => "%{value} is not a valid state"

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
