class Tag < ApplicationRecord
  def self.names_to_hash
    all.reduce({}) { |memo, tag| memo.update(tag[:name] => tag[:id]) }
  end
end