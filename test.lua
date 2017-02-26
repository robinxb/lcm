local Class = require "lcm"

assert(type(class) == "table")

assert(class['not_exist'] == nil )
assert(class[{}] == nil)

local c1 = class("c1")

assert(class["c1"] == c1)

function c1:new(nickname)
    self.nickname = nickname
    return self
end

function c1:hello()
    local str = "c1 hello " .. self.nickname
    return str
end

c1.nickname = "classnick c1"

local c2 = class("c2", "c1")
function c2:hello()
    local str = "c2 hello " .. self.nickname
    return str
end
assert(class["c2"] == c2)

local m1_1 = c1('m1_1')
assert(m1_1.nickname == "m1_1")
assert(c1.nickname == "classnick c1")

local m1_2 = c1('m1_2')
assert(m1_1 ~= m1_2)
assert(m1_1.nickname == "m1_1")
assert(m1_2.nickname == "m1_2")
assert(m1_1:hello() == "c1 hello " .. m1_1.nickname)
assert(m1_2:hello() == "c1 hello " .. m1_2.nickname)

local m2 = c2("m2")
assert(m2.nickname == "m2")
assert(m2:hello() == "c2 hello " .. m2.nickname)

local c3 = class("c3", c1)
function c3:new()
end

local m3 = c3('no_use')
assert(m3.nickname == "classnick c1")

assert(m1_1.__class_name == "c1")
assert(m1_2.__class_name == "c1")
assert(m2.__class_name == "c2")
assert(m3.__class_name == "c3")

local PointBase = Class("PointBase")
function PointBase:new(x, y)
    PointBase.super.new(self)
    self.x = x or 0
    self.y = y or 0
    return self
end

function PointBase:__tostring()
    return string.format("Class<%s> x: %d, y: %d", self.__class_name, self.x or 0, self.y or 0)
end

function PointBase.__add(p1, p2)
    local result = PointBase(p1.x + p2.x, p1.y + p2.y)
    return result
end

local p1 = PointBase(1, 0)
local p2 = PointBase(0, 2)
assert(PointBase == Class['PointBase'])
assert(tostring(p1 + p2) == "Class<PointBase> x: 1, y: 2")

local PointChild = Class("PointChild", PointBase)
assert(PointChild.new == PointBase.new)
local child = PointChild(3, 3)
assert(tostring(child) == "Class<PointChild> x: 3, y: 3")

