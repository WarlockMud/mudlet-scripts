--Okienka::GeyserExt::LayoutBox
Geyser.LayoutBox = Geyser.Container:new({
    name = "LayoutBoxClass"
 })

function Geyser.LayoutBox:add (window, cons)
 Geyser.add(self, window, cons)
 if not self.defer_updates then
    self:reposition()
 end
end

--- Responsible for placing/moving/resizing this window to the correct place/size.
-- Called on window resize events.
function Geyser.LayoutBox:reposition()
 self.parent:reposition()
  if(self.align == "LEFT") then
      self:reposition_left()
  elseif(self.align == "BOTTOM") then
      self:reposition_bottom()
  elseif(self.align == "RIGHT") then
      self:reposition_right()
  else
      echo("NO ALIGN PROVIDED FOR LayoutBox!\n")
  end
end

function Geyser.LayoutBox:reposition_bottom()
 local window_height = self:get_height()
 local start_y = window_height
 for _, window_name in ipairs(self.windows) do
    local window = self.windowList[window_name]
    local width = window.width
    local height = window.height
    if window.h_policy == Geyser.Dynamic then
       width = self:get_width()
    end
    if window.v_policy == Geyser.Dynamic then
       height = window_height * window.v_stretch_factor
    end
    window:resize(width, height)
      start_y = start_y - window:get_height()
      window:move(0, math.max(0, start_y))
      --echo(self.name .. ": window " .. window.name .. " position BOTTOM completed. End_y: " .. start_y .. "\n")
 end
end

function Geyser.LayoutBox:reposition_top()
 local window_height = self:get_height()
 local start_y = 0
 for _, window_name in ipairs(self.windows) do
    local window = self.windowList[window_name]
    local width = window.width
    local height = window.height
    if window.h_policy == Geyser.Dynamic then
       width = self:get_width()
    end
    if window.v_policy == Geyser.Dynamic then
       height = window_height * window.v_stretch_factor
    end
    window:resize(width, height)
      window:move(0, math.max(0, start_y))
      start_y = start_y + window:get_height()
      --echo(self.name .. ": window " .. window.name .. " position TOP completed. End_y: " .. start_y .. "\n")
 end
end

function Geyser.LayoutBox:reposition_left()
 local window_width = self:get_width()
 local start_x = window_width
 for _, window_name in ipairs(self.windows) do
    local window = self.windowList[window_name]
    local width = window.width
    local height = window.height
    if window.h_policy == Geyser.Dynamic then
       width = self:get_width()
    end
    if window.v_policy == Geyser.Dynamic then
       height = window_height * window.v_stretch_factor
    end
    window:resize(width, height)
      start_x = start_x - window:get_width()
      window:move(math.max(0, start_x), 0)
      --echo(self.name .. ": window " .. window.name .. " position LEFT completed. End_x: " .. start_x .. "\n")
 end
end

function Geyser.LayoutBox:reposition_right()
 local window_width = self:get_width()
 local start_x = 0
 for _, window_name in ipairs(self.windows) do
    local window = self.windowList[window_name]
    local width = window.width
    local height = window.height
    if window.h_policy == Geyser.Dynamic then
       width = self:get_width()
    end
    if window.v_policy == Geyser.Dynamic then
       height = window_height * window.v_stretch_factor
    end
    window:resize(width, height)
      window:move(math.max(0, start_x), 0)
      start_x = start_x + window:get_width()
      --echo(self.name .. ": window " .. window.name .. " position RIGHT completed. End_x: " .. start_x .. "\n")
 end
end

Geyser.LayoutBox.parent = Geyser.Container

function Geyser.LayoutBox:new(cons, container)
 -- Initiate and set Window specific things
 cons = cons or {}
 cons.type = cons.type or "LayoutBox"
 
 -- Call parent's constructor
 local me = self.parent:new(cons, container)
 setmetatable(me, self)
 self.__index = self
 return me
end