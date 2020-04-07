extends Node2D
# Setting Paths
var path = "user://data.json"
var path2 = "res://data.json"
# Setting default path
var current_path = path
# Setting default note
var data = {
	"name": "note",
	"createdAt": OS.get_unix_time(),
	"note": ""
	}
#####################################################
func _ready():
	
	var file = File.new();	
	if not file.file_exists(current_path):
		print("File Does not exist")
		save_file(data)
		return
	file.open(current_path, file.READ)
	var data = file.get_as_text()
	var json = parse_json(data)
	$HBoxContainer/Editor.text = json.note
	setStat()
	return
#####################################################
func save_file(data):
	var file = File.new();	
	data.note = $HBoxContainer/Editor.text;
	setStat()
	file.open(current_path, File.WRITE)
	file.store_line(to_json(data))
	file.close()
	return
#####################################################
# Save to file When the edior changes
func _on_Editor_text_changed():
	save_file(data)
	return
#####################################################
# Set Statistics
func setStat():
	var txt = $HBoxContainer/Editor.text
	var word_count = txt.split(' ', false).size()
	var lines = txt.split("\n",false).size()
	$Stats.text = "W: " + str(word_count) + "  L: " + str(lines)
	return
#####################################################
