extends CanvasLayer

var player;

onready var primary_info = $Control/UserInfo/VBoxContainer/Weapons/Primary/Primary_Container
onready var secondary_info = $Control/UserInfo/VBoxContainer/Weapons/Secondary/Secondary_Container
onready var inventory = $Control/Top_Right/Inventory
onready var health = $Control/Health/Health
onready var map =  $Control/Minimap
# Called when the node enters the scene tree for the first time.
