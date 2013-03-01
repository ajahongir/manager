class Object
  def to_bool
    return true if self == true || self.to_s == "true"
    return false if self == false || self.to_s == "false"
    return nil
  end
end