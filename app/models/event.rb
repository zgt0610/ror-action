# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  is_public   :boolean
#  capacity    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string(255)
#  category_id :integer
#
# Indexes
#
#  index_events_on_category_id  (category_id)
#

class Event < ActiveRecord::Base
  has_one :location, :dependent => :destory
  has_many :attendees, -> { where(["created_at > ?", Time.now -7.days]).order("id DESC") }, :dependent => :destroy
  belongs_to :category
  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  validates_presence_of :name
end
