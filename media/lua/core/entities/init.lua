--[[! File: lua/core/entities/init.lua

    About: Author
        q66 <quaker66@gmail.com>

    About: Copyright
        Copyright (c) 2013 OctaForge project

    About: License
        This file is licensed under MIT. See COPYING.txt for more information.

    About: Purpose
        OctaForge standard library loader (Entity system).
]]

#log(DEBUG, ":::: State variables.")
require("core.entities.svars")

#log(DEBUG, ":::: Entities.")
ents = require("core.entities.ents")

#log(DEBUG, ":::: Entities: basic set.")
require("core.entities.ents_basic")