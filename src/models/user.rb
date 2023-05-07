class User < ActiveRecord::Base
  def self.create_user(name, password)
    user = User.new(name: name, password: password)
    user.save
  end
end
