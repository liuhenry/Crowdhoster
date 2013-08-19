class Update < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :campaign

  belongs_to :campaign
  
  attr_accessible :title, :body, :publish_date

  validates :title, :body, :publish_date, presence: true
  validate :publish_date_cannot_be_in_the_past


  private

  def publish_date_cannot_be_in_the_past
    if self.publish_date_changed? && !self.publish_date.blank? && self.publish_date < Time.current
      errors.add(:publish_date, "can't be in the past")
    end
  end

end
