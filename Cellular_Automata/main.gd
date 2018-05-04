extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var grid = []
var gridSize = Vector2( 16, 16 )
var probability = 45

onready var groundTileScene = preload( "res://Ground.tscn" )
onready var wallTileScene = preload( "res://Wall.tscn" )
var tileWidth
var tileHeight

func _ready():
	var groundTile = groundTileScene.instance()
	tileWidth = groundTile.get_region_rect().size.x
	tileHeight = groundTile.get_region_rect().size.y
	print( "Tile Size:" + str( tileWidth ) + " * " + str( tileHeight ) )
	
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
	
		
	grid = []
	#grid.resize( gridSize.y )
	for x in range( width ):
		grid.append( [] )
		for y in range( height ):
			grid[x].append( [] )
			
	for x in range( width ):
		for y in range( height ):
			if x == 0 or x == ( width - 1 ) or y == 0 or y == ( height - 1 ):
				grid[x][y] = "Wall"
			else:
				var p = randi() % 100
				if p > probability:
					grid[x][y] = "Ground"
				else:
					grid[x][y] = "Wall"
			#grid[x][y] = "(" + str(x) + "," + str(y) + ")"
			

			#printraw( grid[x][y] )
			#grid[x][y] = "(" + str(x) + "," + str(y) + ")"
		#print( "\n" )	
func Render():
	for child in $Tiles.get_children():
		child.queue_free()
		
	for y in range( gridSize.y ):
		for x in range( gridSize.x ):
			var tile
			if grid[x][y] == "Ground":
				tile = groundTileScene.instance()
			else:
				tile = wallTileScene.instance()
				
			tile.position = Vector2( x * tileWidth, y * tileHeight )
			$Tiles.add_child( tile )

func _on_ResetButton_pressed():
	Generate( gridSize.x, gridSize.y )
	Render()

func _on_IterateButton_pressed():
	#var newGrid = []
	#for x in range( gridSize.x ):
	#	newGrid.append( [] )
	#	for y in range( gridSize.y ):
	##			
	var newGrid = grid
	
	for x in range( 1, gridSize.x - 1 ):
		for y in range( 1, gridSize.y - 1 ):
			var wallCount = 0
			for neighborX in range( -1, 2 ):
				for neighborY in range( -1, 2 ):
					#print( str( neighborX ) + "+" + str( neighborY ) )
					if grid[x+neighborX][y+neighborY] == "Wall":
						wallCount = wallCount + 1
						
			print( "Wall Count:" + str( wallCount ) )
			if wallCount >= 5:
				newGrid[x][y] = "Wall"
			else:
				newGrid[x][y] = "Ground"
				
	grid = newGrid
	#Generate( gridSize.x, gridSize.y )
	Render()

func _on_ProbabilitySlider_value_changed(value):
	$ProbabilityLabel.text = "Probability:" + str( value )
	probability = value
