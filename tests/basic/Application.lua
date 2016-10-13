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
	Application = function(unitTest)
		local terralib = getPackage("terralib")
		local emas = filePath("emas.tview", "terralib")
		local emasDir = Directory("EmasWebMap")
		local appFiles = {
			["data"] = true,
			["index.html"] = true,
			["publish.css"] = true,
			["publish.js"] = true,
			["config.js"] = true,
			["colorbrewer.min.js"] = true
		}

		local layout = Layout{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			base = "satellite",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778}
		}

		-- Testing Application: project: tview, layers: nil.
		local app = Application{
			project = emas,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(#app.layers, getn(app.project.layers))

		local count = 0
		local emasFiles = emasDir:list()
		forEachFile(emasFiles, function(file)
			unitTest:assert(appFiles[file])
			count = count + 1
		end)

		unitTest:assertEquals(#emasFiles, count)

		count = 0
		forEachFile(app.datasource:list(), function()
			count = count + 1
		end)

		unitTest:assertEquals(#app.layers, count + 1) -- TODO #14

		-- Testing Application: project: Project, layers: nil.
		local fname = File("emas-test.tview")
		fname:deleteIfExists()
		emasDir = "EmasWebMap"
		emas = terralib.Project{
			file = tostring(fname),
			clean = true,
			author = "Carneiro, H.",
			title = "Emas database",
			firebreak = filePath("firebreak_lin.shp", "terralib"),
			cover = filePath("accumulation_Nov94May00.tif", "terralib"),
			river = filePath("River_lin.shp", "terralib"),
			limit = filePath("Limit_pol.shp", "terralib")
		}

		app = Application{
			project = emas,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(#app.layers, getn(app.project.layers))

		count = 0
		emasFiles = app.output:list()
		forEachFile(emasFiles, function(file)
			unitTest:assert(appFiles[file])
			count = count + 1
		end)

		unitTest:assertEquals(#emasFiles, count)

		count = 0
		forEachFile(app.datasource:list(), function()
			count = count + 1
		end)

		unitTest:assertEquals(#app.layers, count + 1) -- TODO #14

		-- Testing Application: project: Project, layers: {firebreak, cover, river}.
		local layers = {"firebreak", "cover", "river"}
		app = Application{
			project = emas,
			layers = layers,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(#app.layers, getn(app.project.layers) - 1)

		count = 0
		emasFiles = app.output:list()
		forEachFile(emasFiles, function(file)
			unitTest:assert(appFiles[file])
			count = count + 1
		end)

		unitTest:assertEquals(#emasFiles, count)

		count = 0
		forEachFile(app.datasource:list(), function()
			count = count + 1
		end)

		unitTest:assertEquals(#app.layers, count + 1) -- TODO #14

		-- Testing Application: project: Project, layers: {firebreak_lin, accumulation_Nov94May00, River_lin}.
		layers = {
			filePath("firebreak_lin.shp", "terralib"),
			filePath("accumulation_Nov94May00.tif", "terralib"),
			filePath("River_lin.shp", "terralib")
		}

		app = Application{
			project = emas,
			layers = layers,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(#app.layers, getn(app.project.layers) - 1)

		count = 0
		emasFiles = app.output:list()
		forEachFile(emasFiles, function(file)
			unitTest:assert(appFiles[file])
			count = count + 1
		end)

		unitTest:assertEquals(#emasFiles, count)

		count = 0
		forEachFile(app.datasource:list(), function()
			count = count + 1
		end)

		unitTest:assertEquals(#app.layers, count + 1) -- TODO #14

		-- Testing Application: project: nil, layers: {firebreak_lin, accumulation_Nov94May00, River_lin, Limit_pol}.
		table.insert(layers, filePath("Limit_pol.shp", "terralib"))
		app = Application{
			layers = layers,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertType(app.project, "Project")
		unitTest:assertType(app.layers, "table")
		unitTest:assertType(app.output, "Directory")
		unitTest:assert(app.output:exists())
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(#app.layers, getn(app.project.layers))

		count = 0
		emasFiles = app.output:list()
		forEachFile(emasFiles, function(file)
			unitTest:assert(appFiles[file])
			count = count + 1
		end)

		unitTest:assertEquals(#emasFiles, count)

		count = 0
		forEachFile(app.datasource:list(), function()
			count = count + 1
		end)

		unitTest:assertEquals(#app.layers, count + 1) -- TODO #14

		fname:deleteIfExists()
		if app.output:exists() then app.output:delete() end
	end,
	__tostring = function(unitTest)
		local emas = filePath("emas.tview", "terralib")
		local emasDir = Directory("EmasWebMap")

		local layout = Layout{
			title = "Emas",
			description = "Creates a database that can be used by the example fire-spread of base package.",
			base = "satellite",
			zoom = 14,
			center = {lat = -18.106389, long = -52.927778}
		}

		local app = Application{
			project = emas,
			layout = layout,
			clean = true,
			progress = false,
			output = emasDir
		}

		unitTest:assertType(app, "Application")
		unitTest:assertEquals(app.clean, true)
		unitTest:assertEquals(app.progress, false)
		unitTest:assertEquals(tostring(app), [[clean       boolean [true]
datasource  Directory
layers      vector of size 5
layout      Layout
legend      string [Legend]
output      Directory
progress    boolean [false]
project     Project
]])

		if emasDir:exists() then emasDir:delete() end
	end
}

