extends Node2D
class_name Test

@onready var tree : PackedScene = load("res://scenes/tree.tscn")
@onready var mouse_contorno : Sprite2D = $MouseContorno


func _ready() -> void:
	print("Running test class")

func _process(_delta: float) -> void:
	mouse_contorno.global_position = get_mouse_grid_position() * 16

func get_mouse_grid_position() -> Vector2i:
	return get_global_mouse_position().floor() / 16

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		print("add tree")
		var my_tree : Area2D = tree.instantiate()
		add_child(my_tree)
		my_tree.global_position = get_mouse_grid_position() * 16

