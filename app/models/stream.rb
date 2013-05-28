class Stream < ActiveRecord::Base
  validates :title, presence: true

  before_create :setup_stream
  before_destroy :delete_room
  has_and_belongs_to_many :channels

  extend FriendlyId
  friendly_id :hash_token

  def self.by_channel(channel_id)
    Stream.joins(:channels).where("channel_id = ?", channel_id)
  end

  def delete_room
    NUVE.deleteRoom(self.to_param)
  end

  def setup_stream
    #HOOK for NUVE
    room = JSON.parse(NUVE.createRoom(self.title))
    self.hash_token = room["_id"]
    #self.hash_token = Digest::MD5.hexdigest(self.inspect + Time.now.to_s)
    self.started_on = Time.now
  end
end
