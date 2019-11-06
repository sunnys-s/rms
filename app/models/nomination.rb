class Nomination < ApplicationRecord
  include RailsStateMachine::Model

  has_many :nominees
  has_many :ratings
  belongs_to :nominator, polymorphic: true, optional: true
  accepts_nested_attributes_for :nominees
  accepts_nested_attributes_for :ratings
  belongs_to :award
  has_many :nomination_attachments

  state_machine do
    state :draft, initial: true
    state :review_pending
    state :l1_review_pending
    state :l2_review_pending
    state :final_review_pending
    state :l1_approved
    state :l1_rejected
    state :l2_approved
    state :l2_rejected
    state :approved
    state :rejected

    event :request_review do
      transitions from: [:draft, :rejected], to: :review_pending
    end

    event :approve do
      transitions from: :final_review_pending, to: :approved
    end

    event :reject do
      transitions from: :final_review_pending, to: :rejected
    end
  end
end
