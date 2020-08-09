-- Copyright (C) 2012 Trustwave
-- http://www.trustwave.com
-- 
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; version 2 dated June, 1991 or at your option
-- any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
-- 
-- A copy of the GNU General Public License is available in the source tree;
-- if not, write to the Free Software Foundation, Inc.,
-- 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

description = [[
Gets a screenshot from the host
]]

author = "Ryan Linn <rlinn at trustwave.com>"

license = "GPLv2"

categories = {"discovery", "safe"}

-- Updated the NSE Script imports and variable declarations
local shortport = require "shortport"

local stdnse = require "stdnse"

portrule = shortport.http

action = function(host, port)
	
	-- Screenshots will be called screenshot-namp-<IP>:<port>.png
        local filename = "screenshot-nmap-" .. host.ip .. "-" .. host.targetname .. "-" .. port.number .. ".jpg"
	
	-- Execute the shell command wkhtmltoimage <url> <filename>
	local cmd = "wkhtmltoimage -n " .. port.version.name .. "://" .. host.targetname .. ":" .. port.number .. " " .. filename .. " 2> /dev/null   >/dev/null"
	
	local ret = os.execute(cmd)

	-- If the command was successful, print the saved message, otherwise print the fail message
	local result = "failed (verify wkhtmltoimage is in your path)"

	if ret then
		result = "Saved to " .. filename
	end

	-- Return the output message
	return stdnse.format_output(true,  result)

end
