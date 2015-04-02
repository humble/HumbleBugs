class Port < ActiveRecord::Base
  belongs_to :game, :inverse_of => :ports, :touch => true
  belongs_to :developer, :inverse_of => :ports

  acts_as_taggable_on :platforms

  STATES = Types::Port::STATES

  validates_presence_of :game_id, :state
  validates_inclusion_of :state, :in => STATES.map { |m| m.second.to_s }, :message => "state %{value} is not a valid state"
end
