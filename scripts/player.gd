extends CharacterBody2D

@onready var camera = $Camera2D
@export var move_speed : float = 300


func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return
	
	# hacky
	global_position = get_node("../World/Spawn/Marker2D").global_position
	
	camera.make_current()
	

func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority(): return
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * move_speed

	move_and_slide()
