class Employee < ActiveRecord::Base
  
  attr_accessible :first_name, :last_name, :phone, :status, :post_id, :name

  validates :first_name, uniqueness: { scope: :last_name, message: "This name is already taken" }, presence: true, allow_nil: false
  validates :post, presence: true

  belongs_to :post
 
  delegate :name, to: :post, allow_nil: true, prefix: true

  scope :sort, lambda { |sort_column, sort_direction|
    if sort_column == 'post_id'
      sort_column = "posts.name"
      order("#{ sort_column } #{ sort_direction }").includes(:post).joins(:post)
    else
      order("#{ sort_column } #{ sort_direction }").includes(:post)
    end
  }
  
  scope :filter_status, Proc.new { |options|
    where(status: options[:status].to_bool) unless options[:status].to_bool.nil?
  }

  scope :search, lambda { |options| 
    where('first_name LIKE ? OR last_name LIKE ?', "%#{ options[:search] }%", "%#{ options[:search] }%") unless options[:search].blank?
  }

  def name
    "#{ first_name } #{ last_name }" if self.first_name || self.last_name
  end

  def name=(first_last)
    self.first_name, self.last_name = first_last.split(' ') if first_last.present?
  end

end