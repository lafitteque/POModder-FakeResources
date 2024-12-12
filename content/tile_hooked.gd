extends Node2D

const FAKE_IRON = "fake_iron"
const FAKE_WATER = "fake_water"
const FAKE_SAND = "fake_sand"

func _ready():
	print("Tile Hook Ready")
	
func serialize(tile):
	pass

func deserialize(tile):
	match tile.type:
		FAKE_IRON: 
			tile.set_meta("destructable", true)
			var v = Vector2(randi_range(0, 4), 0)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
		FAKE_WATER: 
			tile.set_meta("destructable", true)
			var v = Vector2(randi_range(0,4), 1)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
		FAKE_SAND: 
			tile.set_meta("destructable", true)
			var v = Vector2(randi_range(0,4), 2)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
			
func setTypeBegin(tile,type):
	# Used for worldmodifier changed or in order to overwrite the data Map.gd gives to the tile
	# returns true if should force tile to be destructible
	return false

func setType(tile,type, baseHealth) -> float:
	# Add visuals to the tile with customInitResourceSprite or by adding your own animation 
	# (see "glass" in AllYouCanMine)
	# Returns the new baseHealth
	match type:
		FAKE_IRON:
			set_meta("destructable", true)
			var v = Vector2(randi_range(0, 4), 0)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
			baseHealth += Data.of("map.ironAdditionalHealth") + 2
		FAKE_WATER:
			set_meta("destructable", true)
			var v = Vector2(randi_range(0,4), 1)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
			baseHealth += Data.of("map.waterAdditionalHealth") + 2
		FAKE_SAND:
			set_meta("destructable", true)
			var v = Vector2(randi_range(0,4), 2)
			var path = "res://mods-unpacked/POModder-FakeResources/images/fake_resources_spritesheet.png"
			tile.customInitResourceSprite(v , 5 , 3, path)
			baseHealth += Data.of("map.sandAdditionalHealth") + 2
	Style.init(tile)
	return baseHealth
	
func hit(tile,type,dir,dmg):
	# Called when hit. If you want to check if the tile is broken, use tileBreak(...)
	pass
	
func tileBreak(tile,type,dir,dmg):
	# Called when the tile breaks
	pass	
	
func set_meta_destructable(tile,type) -> bool:
	if type in [FAKE_IRON, FAKE_WATER, FAKE_SAND]:
		return true
	return false
