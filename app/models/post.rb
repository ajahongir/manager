class Post < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true, allow_blank: false
  
  has_many :employees

  attr_accessible :name
  
  scope :removable, lambda { 
    select("posts.*, IF((SELECT count(*) FROM employees WHERE employees.post_id = posts.id) > 0, true, false) as busy")
  }

  def busy?
    if self.attributes.has_key? :busy
      self[:busy] > 0
    else
      self.employees.count > 0
    end
  end
  
end
