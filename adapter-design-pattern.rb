# Adapter Design Pattern
#
# Symptoms:
#   class Animal
#     def speak(kind)
#       puts case kind
#     when :dog then "woof!"
#     when :cat then "meow!"
#     when :owl then "hoo!"
#     end
# end
# end
#
# Animal.new.speak(:dog)
#
# This works, but what if a developer wants to add a new way? With conditional branching, the entire method would need to be overwritten.

require 'byebug'

class Animal
  module Adapter
    module Dog
      def self.speak
        puts "woof!"
      end
    end

    module Cat
      def self.speak
        puts "meow!"
      end
    end
  end

  attr_accessor :species

  def initialize(species: :dog)
    @species = species
  end

  def speak
    adapter.speak
  end

  def adapter
    Animal::Adapter.const_get(species.to_s.capitalize)
  end
end

byebug

animal = Animal.new
animal.speak
animal.adapter = :cat
animal.speak

# Adapters are great ways to incorporate multiple ways of accomplishing something without resorting to mountains of conditional branching. They also let you split approaches into separate libraries that can have their own dependencies. If adapters are loaded in a lazy manner, broken adapters will not affect a project unless they are used.
