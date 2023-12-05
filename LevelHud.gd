extends XRCamera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next = Vector3($WorldHud.transform.basis.x)
	next[1] =  -self.transform.basis.x[1]
	
	$WorldHud.transform.basis.x = next
