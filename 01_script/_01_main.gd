extends Node2D

@onready var zahl_label = $clicker_stand

var value: int = 0
var step_size: int = 1

# Swipe-Tracking
var start_pos: Vector2
var delta_steps: int = 0
var swipe_threshold := 100.0  # ab 100 px wird horizontaler Swipe erkannt
var vertical_step_size := 50.0  # vertikal alle 50 px ein Schritt

func _ready() -> void:
	global.jump_1 = step_size
	update_display()

func _process(delta: float) -> void:
	zahl_label.text = str(global.clicker_stand_00)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			start_pos = event.position
			delta_steps = 0
		else:
			apply_swipe(event.position)
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		move_swipe(event.position)
	elif event is InputEventScreenTouch:
		if event.pressed:
			start_pos = event.position
			delta_steps = 0
		else:
			apply_swipe(event.position)
	elif event is InputEventScreenDrag:
		move_swipe(event.position)

func move_swipe(current_pos: Vector2):
	var diff := start_pos - current_pos
	# Nur vertikales Verhalten während der Bewegung – horizontales erst beim Loslassen
	delta_steps = int(diff.y / vertical_step_size)

func apply_swipe(end_pos: Vector2):
	var diff := end_pos - start_pos
	var abs_x: float = abs(diff.x)
	var abs_y: float = abs(diff.y)


	# Prüfen, ob horizontale oder vertikale Bewegung dominiert
	if abs_x > abs_y and abs_x > swipe_threshold:
		if diff.x > 0:
			on_swipe_right()
		else:
			on_swipe_left()
	else:
		if delta_steps != 0:
			global.clicker_stand_00 += delta_steps * step_size  # umdrehen für natürliches Wischen
	start_pos = Vector2.ZERO
	delta_steps = 0

# ----- Szenewechsel-Logik -----
func on_swipe_left():
	print("👉 Szene nach rechts wechseln")  # z.B. nächste Szene
	get_tree().change_scene_to_file("res://00_scene/00_main.tscn")

func on_swipe_right():
	print("geht nicht weiter")   # z.B. vorherige Szene
	

# ----- Buttons -----
func _on_top_pressed() -> void:
	global.clicker_stand_00 += step_size

func _on_button_pressed() -> void:
	global.clicker_stand_00 -= step_size


func update_display():
	zahl_label.text = str(global.clicker_stand_00)
	
	
	
	
	
	
	
	
	
	
	##########################################
func _on_side_buttons_5_reset_pressed() -> void:
	global.clicker_stand_00 = 0


func _on_side_buttons_1_jump_1_pressed() -> void:
	step_size = global.jump_1

func _on_side_buttons_2_jump_2_pressed() -> void:
	step_size = global.jump_2

func _on_side_buttons_3_jump_3_pressed() -> void:
	step_size = global.jump_3
