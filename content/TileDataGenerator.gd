extends "res://content/map/generation/TileDataGenerator.gd"

var TILE_FAKE_IRON = 21
var TILE_FAKE_WATER = 22
var TILE_FAKE_SAND = 23


func generate_resources(rand):
	super(rand)
	var original_cell_coords:Array = $MapData.get_used_biome_cells()
	var borderCells = findOutsideBorderCells()
	Utils.shuffle(original_cell_coords, rand)
	var ironClusterCenters = $MapData.get_resource_cells_by_id(Data.TILE_IRON).duplicate()
	
	if "worldmodifierfake" in Level.loadout.modeConfig.get(CONST.MODE_CONFIG_WORLDMODIFIERS, []):
		var fake_iron_rate = 20.0
		var fake_water_rate = 10.0
		var fake_sand_rate = 7.0
		generate_curstom_tiles(ironClusterCenters, original_cell_coords, borderCells,fake_iron_rate, TILE_FAKE_IRON)
		generate_curstom_tiles(ironClusterCenters, original_cell_coords, borderCells,fake_water_rate, TILE_FAKE_WATER)
		generate_curstom_tiles(ironClusterCenters, original_cell_coords, borderCells,fake_sand_rate, TILE_FAKE_SAND)
	
		
func generate_curstom_tiles(ironClusterCenters, original_cell_coords, borderCells, type_rate,typeId):
	var typeAmount = round(1.0*type_rate * 0.001 * original_cell_coords.size())
	var availableCells = $MapData.get_resource_cells_by_id(Data.TILE_DIRT_START)
	Utils.shuffle(availableCells,rand)
	var freeTileIndex = 0
	for _j in typeAmount:
		$MapData.set_resourcev(availableCells[freeTileIndex], typeId)
		freeTileIndex += 1
	var iterations = 100
	var totalMove = Vector2()
	var averagedLastTotalMoves = Vector2()
	var zeroMoves = 0
	
