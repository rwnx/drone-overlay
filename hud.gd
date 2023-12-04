extends CanvasLayer


func _ready():
	$NoiseVideo.finished.connect(self._finished)

func _finished():
	# loop
	$NoiseVideo.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
