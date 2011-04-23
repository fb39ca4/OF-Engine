---
-- base_appman.lua, version 1<br/>
-- Application manager for Lua<br/>
-- <br/>
-- @author q66 (quaker66@gmail.com)<br/>
-- license: MIT/X11<br/>
-- <br/>
-- @copyright 2011 CubeCreate project<br/>
-- <br/>
-- Permission is hereby granted, free of charge, to any person obtaining a copy<br/>
-- of this software and associated documentation files (the "Software"), to deal<br/>
-- in the Software without restriction, including without limitation the rights<br/>
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell<br/>
-- copies of the Software, and to permit persons to whom the Software is<br/>
-- furnished to do so, subject to the following conditions:<br/>
-- <br/>
-- The above copyright notice and this permission notice shall be included in<br/>
-- all copies or substantial portions of the Software.<br/>
-- <br/>
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br/>
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br/>
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br/>
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br/>
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,<br/>
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN<br/>
-- THE SOFTWARE.
--

local base = _G
local string = require("string")
local CAPI = require("CAPI")
local log = require("cc.logging")
local glob = require("cc.global")
local class = require("cc.class")
local lent = require("cc.logent")
local msgsys = require("cc.msgsys")
local sig = require("cc.signals")

--- Application manager for cC Lua interface. DEPRECATED
-- @class module
-- @name cc.appman
module("cc.appman")

--- Set current application class.
-- @param Application class to set.
function set_appclass(_c)
    log.log(log.DEBUG, "appman: setting appclass to " .. base.tostring(_c))

    inst = _c()

    log.log(log.DEBUG, "appman: instance is " .. base.tostring(inst))
end

--- Root application class. Not meant to be used directly.
-- @class table
-- @name application
application = class.new()

--- Return string representation of application.
-- @return String representation of application.
function application:__tostring() return "application" end

--- "Do click" event, called when player clicks position in the world. By default,
-- client click is called and if it returns false value (which it always returns by default),
-- server gets contacted for that matter via message. client_click can be overriden to achieve
-- specific behavior.
-- @param btn Button that gets clicked, 1, 2, 3.
-- @param down Boolean value, true if button is pressed, false if it's released.
-- @param pos Position where it happens.
-- @param ent Entity for which it happens (if it happened for entity, if not, then it's nil)
-- @param x Absolute x position on the screen (in [0,1])
-- @param y Absolute y position on the screen (in [0,1])
function application:do_click(btn, down, pos, ent, x, y)
    if not self:client_click(btn, down, pos, ent, x, y) then
        local uid = ent and ent.uid or -1
        msgsys.send(CAPI.do_click, btn, base.tonumber(down), pos.x, pos.y, pos.z, uid)
    end
end

--- Client click event. For params, see do_click. This gets always called by do_click,
-- but by default always returns false, so server gets contacted on do_click.
-- You can override client_click on your entity and achieve specific clientside behavior.
-- @return If overriden in entity, entity's client_click return value, false otherwise.
-- @see application:do_click
function application:client_click(btn, down, pos, ent, x, y)
    if ent and ent.client_click then
        return ent:client_click(btn, down, pos, x, y)
    end
    return false
end

--- Serverside click event. See do_click.
-- @return If overriden in entity, entity's click return value, false otherwise.
-- @see application:do_click
function application:click(btn, down, pos, ent)
    if ent and ent.click then
        return ent:click(btn, down, pos)
    end
    return false
end

sig.methods_add(application)

--- Dummy application class, default if not overriden.
-- @class table
-- @name __dummy_application
__dummy_application = class.new(application)
function __dummy_application:__tostring() return "__dummy_application" end

function __dummy_application:do_click(...)
     log.log(log.WARNING, "(do_click) appman.set_appclass was not called, this is __dummy_application running.")
     application.do_click(self, ...)
end

function __dummy_application:client_click(...)
     log.log(log.WARNING, "(client_click) appman.set_appclass was not called, this is __dummy_application running.")
     application.client_click(self, ...)
end

function __dummy_application:click(...)
     log.log(log.WARNING, "(click) appman.set_appclass was not called, this is __dummy_application running.")
     application.click(self, ...)
end

log.log(log.DEBUG, "Setting dummy application")
set_appclass(__dummy_application)
