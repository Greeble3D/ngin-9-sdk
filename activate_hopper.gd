extends Node3D

@onready var hopper_rigid_body_3d: RigidBody3D = $HopperRigidBody3D
@onready var hopper_lid_left: RigidBody3D = $hopper_lid_left
@onready var hopper_lid_right: RigidBody3D = $hopper_lid_right

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		hopper_lid_right.freeze = false
		hopper_lid_left.freeze = false
		
	if Input.is_action_just_pressed("shift_space"):
		hopper_rigid_body_3d.freeze = false
