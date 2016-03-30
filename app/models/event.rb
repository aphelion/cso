class Event < ActiveRecord::Base
  has_and_belongs_to_many :tickets, class_name: 'Product', join_table: :events_tickets
  has_and_belongs_to_many :addons, class_name: 'Product', join_table: :events_addons
end
