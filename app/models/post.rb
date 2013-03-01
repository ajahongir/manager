class Post < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true, allow_blank: false
  
  has_many :employees

  attr_accessible :name
  
  scope :removable, lambda { 
    select("posts.*, (case when (SELECT count(*) FROM employees WHERE employees.post_id = posts.id) > 5 then true else false end) as busy")
  }

  def busy?
    if self.attributes.has_key? :busy
      self[:busy] > 0
    else
      self.employees.count > 0
    end
  end
  
end
