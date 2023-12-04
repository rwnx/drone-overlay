extends Node3D
 
var interface:WebXRInterface
var vr_supported = false
var enable_passthrough
var initialized
var session_mode = "immersive-ar"
var viewport
 
func _ready() -> void:
	viewport = get_viewport()
	viewport.transparent_bg = true
	$MenuCanvas/Button.pressed.connect(self._on_button_pressed)
	

	
	interface = XRServer.find_interface("WebXR")

	if not interface:
		$MenuCanvas/Button.disabled = true
		$MenuCanvas/Button.text = "WebXR Not Supported"
		return
		
	# WebXR uses a lot of asynchronous callbacks, so we connect to various
	# signals in order to receive them.
	interface.session_supported.connect(self._webxr_session_supported)
	interface.session_started.connect(self._webxr_session_started)
	interface.session_ended.connect(self._webxr_session_ended)
	interface.session_failed.connect(self._webxr_session_failed)
	interface.is_session_supported(session_mode)

 
 
func _webxr_session_supported(_session_mode: String, supported: bool) -> void:
	if supported:
		vr_supported = supported
 
func _on_button_pressed() -> void:
	if not vr_supported:
		OS.alert("Your browser doesn't support webxr mode: %s" % session_mode)
		return
		
	interface.session_mode = session_mode
	interface.requested_reference_space_types = 'bounded-floor, local-floor, local'
	interface.required_features = 'local-floor'
	interface.optional_features = 'bounded-floor'
	
	initialized = interface.initialize()
	
	if not initialized:
		OS.alert("Failed to initialize WebXR")
		return

 
func _webxr_session_started() -> void:
	print("session started")
	$MenuCanvas.visible = false
	# This tells Godot to start rendering to the headset.
	viewport.use_xr = true

	# This will be the reference space type you ultimately got, out of the
	# types that you requested above. This is useful if you want the game to
	# work a little differently in 'bounded-floor' versus 'local-floor'.
	print ("Reference space type: " + interface.reference_space_type)
 
func _webxr_session_ended() -> void:
	print("session ended")
	$MenuCanvas.visible = true
	# If the user exits immersive mode, then we tell Godot to render to the web
	# page again.
	viewport.use_xr = false
 
func _webxr_session_failed(message: String) -> void:
	OS.alert("Failed to initialize: " + message)
 
func _process(_delta: float) -> void:
	pass
 
