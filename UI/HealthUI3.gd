extends Control


var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HeartUIFull2
onready var heartUIEmpty = $HeartUIEmpty2


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	
	
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15
	
func _ready():
	self.max_hearts = PlayerStats2.max_health
	self.hearts = PlayerStats2.health
	PlayerStats2.connect("health_changed", self, "set_hearts")
	PlayerStats2.connect("max_health_changed", self, "set_max_hearts")
