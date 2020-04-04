# feature.rb
# frozen_string_literal: true

# Feature
class Feature
  attr_accessor :name, :board_id, :new_items_group

  def initialize(params)
    params.each do |key, value|
      send("#{key}=", value)
    end
  end
end

    # name, board_id, new_items_group, columns
    # @name = name
    # @board_id = board_id
    # @new_items_group = new_items_group
    # @columns = columns
