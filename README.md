#Lua Class Module (LCM)

A tiny class module written by lua with class support.

##Usage

Drop in lua path, and just require it:


	Local Class = require "lcm"


## Creating new class

	Animal = Class("Aminal")

## Inherit a class

	Cat = Class("Cat", "Animal")

## Custom a constructor

	function Animal:new(name)
		self.name = name
	end

## Get a exist class

	Animal = Class.Animal
	Animal = Class["Animal"]

## Use static class variables

	Cat = Class("Cat")
	Cat.fear = "dog"
	
	my_pet = Cat("Judy")
	print(my_pet.fear) <-- "dog"

## Custom meta methods

	local Point = Class("Point")
	function Point:new(x, y)
		self.x = x or 0
		self.y = y or 0
		return self
	end

	function Point:__tostring()
		return string.format("Class <%s> <%d, %d>", self.__class_name,
		self.x, self.y)
	end

	function Point.__add(p1, p2)
	return Point(p1.x + p2.x, p1.y + p2.y)

	local p1 = Point(1, 2)
	local p2 = Point(1, 1)
	print(p1 + p2) <-- "Class <Point> <2, 3>"

	local Point2 = Class("Point2", "Point") --create a new child class
	local child = Point2(1, 1)
	print(child) <-- "Class <Point2> <1, 2>"

## Use super

	Animal = Class("Animal")
	function Animal:new(name)
		self.name = name
	end

	Cat = Class("Cat", "Animal")
	function Cat:new(name, age)
		Cat.super.new(self, name)
		self.age = age
	end

## License
	[MIT](LICENSE)




