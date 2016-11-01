-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

return {
	View = function(unitTest)
		local data = {
			title = "Emas National Park",
			description = "A small example related to a fire spread model.",
			border = "blue",
			width = 2,
			color = "PuBu",
			visible = false,
			select = "river",
			value = {0, 1, 2}
		}

		local view = View(data)

		unitTest:assertType(view, "View")
		unitTest:assertEquals(view.title, data.title)
		unitTest:assertEquals(view.description, data.description)
		unitTest:assertEquals(view.width, data.width)
		unitTest:assertEquals(view.visible, data.visible)
		unitTest:assertEquals(view.select, data.select)
		unitTest:assertEquals(view.value, data.value)

		unitTest:assertEquals(view.border, data.border)
		unitTest:assertEquals(view.color, data.color)
	end,
	__tostring = function(unitTest)
		local view = View{
			title = "Emas National Park",
			border = "blue",
			width = 2,
			color = "PuBu",
			visible = false,
			select = "river",
			value = {0, 1, 2}
		}

		unitTest:assertEquals(tostring(view), [[border   vector of size 3
color    vector of size 3
select   string [river]
title    string [Emas National Park]
value    vector of size 3
visible  boolean [false]
width    number [2]
]])
	end
}
