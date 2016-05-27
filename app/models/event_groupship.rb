# == Schema Information
#
# Table name: event_groupships
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventGroupship < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
end
