# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  is_public   :boolean
#  capacity    :integer
#  settings    :text(65535)
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
  store :settings, accessors: [:sex, :url]
  has_one :location, :dependent => :destroy
  accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank
  has_many :attendees, -> {order ("id DESC")},  :dependent => :destroy
  belongs_to :category, :dependent => :destroy
  has_many :event_groupships
  has_many :groups, :through => :event_groupships

  # default_scope { order "created_at DESC"}
  validates_presence_of :name
end
