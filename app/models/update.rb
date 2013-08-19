class Update < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :campaign

  belongs_to :campaign
  
  attr_accessible :title, :body
end
