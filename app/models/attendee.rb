# == Schema Information
#
# Table name: attendees
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_attendees_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_4037bda9d5  (event_id => events.id)
#

class Attendee < ActiveRecord::Base
  belongs_to :event
end
