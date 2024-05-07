extends Node

static var folder_name: String = "Sprites"
@export var file_name: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var image_file: Image
	image_file = Image.load_from_file(folder_name + "/" + file_name)
	
	if(!image_file): #also try png
		image_file = Image.load_from_file(folder_name + "/" + file_name.replace(".svg",".png"))
	
	if(image_file):
		self.texture = ImageTexture.create_from_image(image_file)
	else:
		print("Image " + file_name + " not found.")
