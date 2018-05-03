extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var grid = []
var gridSize = Vector2( 16, 16 )

onready var groundTileScene = preload( "res://Ground.tscn" )
var groundTileWidth
var groundTileHeight

func _ready():
	var groundTile = groundTileScene.instance()
	groundTileWidth = groundTile.get_region_rect().size.x
	groundTileHeight = groundTile.get_region_rect().size.y
	print( "Tile Size:" + str( groundTileWidth ) + " * " + str( groundTileHeight ) )
	
	#groundTile.position = Vector2( 100, 100 )
	#add_child( groundTile )

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_WidthSlider_value_changed(value):
	$WidthLabel.text = "Width: " + str( value )
	gridSize.x = value


func _on_HeightSlider_value_changed(value):
	$HeightLabel.text = "Height: " + str( value )
	gridSize.y = value

func Generate( width, height ):
	for child in $Tiles.get_children():
		child.queue_free()
		
	grid = []
	#grid.resize( gridSize.y )
	for x in range( width ):
		grid.append( [] )
		for y in range( height ):
			grid[x].append( [] )
			
	for x in range( width ):
		for y in range( height ):
			grid[x][y] = "."
			#grid[x][y] = "(" + str(x) + "," + str(y) + ")"
			
	for y in range( height ):
		for x in range( width ):
			var groundTile = groundTileScene.instance()
			groundTile.position = Vector2( x * groundTileWidth, y * groundTileHeight )
			$Tiles.add_child( groundTile )
			#printraw( grid[x][y] )
			#grid[x][y] = "(" + str(x) + "," + str(y) + ")"
		#print( "\n" )	

func _on_ResetButton_pressed():
	Generate( gridSize.x, gridSize.y )