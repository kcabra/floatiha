extends StateMachine

const MOVE_TOLERANCE = 0.01
const JUMP_TOLERANCE = 0.3
const IDLE_WAIT = 6.0
var stand_timer = 0
var jump_timer = 0

onready var animator = $AnimationTree.get("parameters/playback")
enum states {stand, idle, walk, fall, jump}

func _ready():
    call_deferred("set_state", states.fall)

func _state_logic(delta):
    jump_timer -= delta
    if Input.is_action_just_pressed("move_up"):
        jump_timer = JUMP_TOLERANCE
    match state:
        states.stand:
            stand_timer += delta
            if stand_timer > IDLE_WAIT:
                animator.travel("idle")
                stand_timer = 0
            continue
        states.walk, states.jump:
            if parent.move_vec.x > 0:
                $"../Sprite".flip_h = false
            elif parent.move_vec.x < 0:
                $"../Sprite".flip_h = true
            continue
        states.jump:
            if Input.is_action_just_released("move_up"):
                parent.cut_jump()
            continue
        states.stand, states.walk:
            parent.hor_move(_get_input_dir(), false)
            if jump_timer >= 0:
                parent.jump()
        states.fall, states.jump:
            parent.apply_gravity(true)
            parent.hor_move(_get_input_dir(), true)
                
    parent.apply_movement()


func _get_transition():
    match state:
        states.walk, states.stand:
            if parent.move_vec.y < 0:
                return states.jump
            if not parent.is_on_ground():
                return states.fall
            continue
        states.stand:
            if abs(parent.move_vec.x) > MOVE_TOLERANCE:
                return states.walk
        states.walk:
            if abs(parent.move_vec.x) <= MOVE_TOLERANCE:
                return states.stand
        states.fall:
            if parent.is_on_ground():
                return states.stand
        states.jump:
            if parent.move_vec.y > 0:
                return states.fall
    return null

func _enter_state(new_state, old_state):
    match new_state:
        states.stand:
            if jump_timer < 0:
                animator.travel("stand")
        states.walk:
            animator.travel("walk")
        states.fall:
            animator.travel("fall")
        states.jump:
            animator.travel("jump")

func _exit_state(old_state, new_state):
    pass

func _get_input_dir():
    var dir = 0
    if Input.is_action_pressed("move_right"):
        dir += 1
    if Input.is_action_pressed("move_left"):
        dir -= 1
    return dir