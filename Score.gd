extends Sprite

var BestScore = [0, 0, 0]
var Scene = null

func _ready():
	var file = File.new()
	file.open("Save.dat", File.READ)
	BestScore = Marshalls.base64_to_utf8(file.get_line()).split("$")
	file.close()
