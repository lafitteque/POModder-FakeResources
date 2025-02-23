extends Node

const MYMODNAME_LOG = "POModder-EndlessCombatMode"
const MYMODNAME_MOD_DIR = "POModder-EndlessCombatMode/"

var dir = ""
var ext_dir = ""
var trans_dir = "res://mods-unpacked/POModder-FakeResources/translations/"
var rerollCount := 1
var mode := ""

func _init():
	ModLoaderLog.info("Init", MYMODNAME_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	ext_dir = dir + "extensions/"
	
	for loc in ["en" , "es" , "fr"]:
		ModLoaderMod.add_translation(trans_dir + "translations." + loc + ".translation")
	
	
func _ready():
	ModLoaderLog.info("Done", MYMODNAME_LOG)
	add_to_group("mod_init")
	
	var pathToModYamlUpgrades = "res://mods-unpacked/POModder-FakeResources/yaml/upgrades.yaml"
	var pathToModYamlAssignments = "res://mods-unpacked/POModder-FakeResources/yaml/assignments.yaml"
	
	Data.parseAssignmentYaml(pathToModYamlAssignments)
	Data.parseUpgradesYaml(pathToModYamlUpgrades)	
	ModLoaderMod.install_script_extension("res://mods-unpacked/POModder-FakeResources/content/TileDataGenerator.gd")
	
func modInit():
	await get_tree().create_timer(0.5).timeout
	var dependencyData = ModLoader.find_child("POModder-Dependency",true,false).data_mod
	
	dependencyData.add_drop_scene("fake_iron",preload("res://mods-unpacked/POModder-FakeResources/content/Drops/FakeIronDrop.tscn") , 1.0)
	dependencyData.add_tile(21, "fake_iron")
	
	dependencyData.add_drop_scene("fake_water", preload("res://mods-unpacked/POModder-FakeResources/content/Drops/FakeWaterDrop.tscn"), 1.0)
	dependencyData.add_tile(22, "fake_water")
	
	dependencyData.add_drop_scene("fake_sand", preload("res://mods-unpacked/POModder-FakeResources/content/Drops/FakeSandDrop.tscn"), 1.0)
	dependencyData.add_tile(23, "fake_sand")
	
	
	var map_hooked = preload("res://mods-unpacked/POModder-FakeResources/content/map_hooked.tscn").instantiate()
	add_child(map_hooked)
	
	var tile_hooked = preload("res://mods-unpacked/POModder-FakeResources/content/tile_hooked.tscn").instantiate()
	add_child(tile_hooked)
	
