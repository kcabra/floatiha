extends KinematicBody2D

var jump_duration = 0.5
var jump_height = 2
var move_vec = Vector2.ZERO

func is_on_ground():
    return $RayCast2D.is_colliding() or $RayCast2D2.is_colliding()

func hor_move(dir, falling):
    move_vec.x = lerp(move_vec.x, dir * 300, 0.5 if !falling else 0.1)

func apply_movement():
    move_vec = move_and_slide(move_vec)

func apply_gravity(falling):
    move_vec.y += _get_gravity() if move_vec.y < 500 else 0

func _get_gravity():
    return (2 * jump_height) / pow(jump_duration, 2)

func cut_jump():
    move_vec.y /= 4

func jump():
    move_vec.y = _get_jump_vel()

func _get_jump_vel():
    return (-2 * jump_height * 64) / jump_duration