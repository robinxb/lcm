local ClassRef = {}
local Class = {}

local function _find(class_name)
    if type(class_name) ~= "string" then return end
    local cls = ClassRef[class_name]
    return cls
end

local _new_instance = function (self, ...)
    local obj = setmetatable({}, self)
    obj:new(...)
    return obj
end

local BaseClass = {}
BaseClass.__index = BaseClass
BaseClass.__class_name = "Object"
BaseClass.__call = _new_instance
function BaseClass:new() end

local function _declear(class, class_name, extend_class)
    local extend_class_obj
    if not class_name or type(class_name) ~= "string" then
        error(string.format("%s is not a valid class name", class_name))
    end
    if _find(class_name) then
        error(string.format("Class %s already exists", class_name))
    end

    if (type(extend_class) == "string") then
        extend_class_obj = _find(extend_class)
        if not extend_class_obj then
            error(string.format("Base class %s not found", extend_class))
        end
    elseif (type(extend_class) == "table") then
        if not extend_class["__class_name"] then
            error('Base class is not a valid class')
        end
        extend_class_obj = extend_class
    else
        extend_class_obj = BaseClass
    end

    local new_cls = setmetatable({}, extend_class_obj)
    for k, v in pairs(extend_class_obj) do
        if k:find("__") == 1 then
            new_cls[k] = v
        end
    end
    new_cls.__class_name = class_name
    new_cls.__index = new_cls
    new_cls.super = extend_class_obj

    ClassRef[class_name] = new_cls

    return new_cls
end

setmetatable(Class, {
    __index = function (_, class_name) return _find(class_name) end,
    __newindex = function (k, v) error("Class does not support newindex") end,
    __call = _declear
})

return Class

