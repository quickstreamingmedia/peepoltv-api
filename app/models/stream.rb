class Stream < ActiveRecord::Base
  validates :title, presence: true

  before_create :setup_stream

  belongs_to :channel
  has_and_belongs_to_many :tags

  has_attached_file :thumbnail, styles: {
    small: '33%',
    medium: '66%',
    large: '100%'
  }

  extend FriendlyId
  friendly_id :hash_token

  #scopes
  scope :by_channel, -> channel_id { where("channel_id = ?", channel_id) }

  def setup_stream
    self.hash_token = Digest::MD5.hexdigest(self.inspect + Time.now.to_s)
    self.started_on = Time.now
  end

  #placeholder for lynckia token
  def token
  end

  #decodes 'data:image/jpg;base64,#{base64_image}'
  def thumb=(value)
    content, base64 = value.split(";")
    base64 = base64.split(",").last
    content = content.split(":").last

    PaperclipAttachment.open(Base64.decode64(base64)) do |data|
      data.original_filename = "image.jpg"
      data.content_type = content
      self.thumbnail = data
    end
  end


  #assigns a new tag to a stream
  def add_tag(tag_name)
    tag = Tag.find_or_create_by_name(tag_name)
    self.tags << Tag.find_or_create_by_name(tag_name) unless self.tags.include?(tag)
  end

  private
  class PaperclipAttachment < StringIO
    attr_accessor :original_filename, :content_type
  end
end
