extends Node2D

const FAKE_IRON = "fake_iron"
const FAKE_WATER = "fake_water"
const FAKE_SAND = "fake_sand"

@onready var data_mod = ModLoader.find_child("POModder-AllYouCanMine",true,false).data_mod
	
func _ready():
	print("Map Hook Ready")
	
func revealTileVisually(map, tile, coord):
	# Just reveal the tile visually if needed (idk a case where you wouldn't do it, but you can)
	# Please, only reveal your type of tile by checking the type like below
	print("Map Hook Reveal Tile")
	if tile.type in [FAKE_IRON, FAKE_WATER, FAKE_SAND]:
		map.revealTileVisually(coord)
		tile.richness = 1

func modmodifyTileWhenRevealed(map,coord,typeId):
	# This can be used to change properties of the tile at the moment it's revealed
	# I used this for a worldmodifier
	pass

func destroyTile(map, tile, withDropsAndSound):
	# This code adds drop. It is generic and will serve for all kind of drops.
	# Just declare your drops to AllYouCanMine data in your ModInit !
	if tile.type in [FAKE_IRON, FAKE_WATER, FAKE_SAND]:
		var drop = data_mod.DROP_FROM_TILES_SCENES.get(tile.type).instantiate()
		drop.position = tile.global_position + 0.6 * Vector2(GameWorld.HALF_TILE_SIZE - randf()*GameWorld.TILE_SIZE, GameWorld.HALF_TILE_SIZE - randf()*GameWorld.TILE_SIZE)
		drop.apply_central_impulse(Vector2(0, 10).rotated(randf() * TAU))
		map.addDrop(drop)
		GameWorld.incrementRunStat("resources_mined")

func getSceneForTileType(tileType):
	# Used for new chambers (like the relic or gadgets)
	pass

func init(fromDeserialize, defaultState):
	# Called at the end of Map.init()
	pass

func beforeCaveGeneration(map, cavePackeScenes, minDistanceToCenter):
	# Used to create your own cave generation, the cavePackScenes is used to generate the map caves.
	# You can : 
	# - Modify it to change the data
	# - Make your own cave generation algorithm here
	pass

func afterCaveGeneration(map):
	# If you need to do something just after the caves are generated
	pass

func addDrop(map,drop) -> bool:
	# Customize the add drop (e.g. for bigger drops, or random drops)
	# If you want your custom drops to react to AllYouCanMine big drop world modifier or random,
	# please add your modifications here
	
	# returns true if Map.addDrop should skip the rest of the function that follows this call.
	
	## worldmodifieraprilfools is automaticaly taken into account with the drop declaration in
	## the ModInit
	
	## worldmodifierbigdrops and worldmodifiersmalldrops are already taken into account with the drop declaration in
	## the ModInit. Nevertheless, if your drop is too big, you should adapt the AllYouCanMine AddDrop
	## (i.e. changing the value of count) for a custom size and return true here.
	return false 
