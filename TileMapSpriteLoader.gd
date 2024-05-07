extends TileMap

static var folder_name: String = "Sprites"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
	
	var grass_image_file: Image = Image.load_from_file(folder_name + "/GrassTile.svg")
	if(!grass_image_file): #also try png
		grass_image_file = Image.load_from_file(folder_name + "/GrassTile.png")
	
	if(grass_image_file):
		tile_set.get_source(0).texture =  ImageTexture.create_from_image(grass_image_file)
	
	
	var dirt_image_file: Image = Image.load_from_file(folder_name + "/DirtTile.svg")
	if(!dirt_image_file): #also try png
		dirt_image_file = Image.load_from_file(folder_name + "/DirtTile.png")
	if(dirt_image_file):
		tile_set.get_source(1).texture =  ImageTexture.create_from_image(dirt_image_file)
	
	

