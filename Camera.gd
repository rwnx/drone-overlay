extends XRCamera3D

var startingPosition
# Called when the node enters the scene tree for the first time.
func _ready():
	startingPosition = $HorizonHud.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$WorldHud.rotation_degrees = Vector3(0,0, -(rotation_degrees.z))
	$HorizonHud.global_position.y = startingPosition.y

	$HorizonHud.rotation_degrees = Vector3(0,0, -(rotation_degrees.z))

