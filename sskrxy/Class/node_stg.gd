extends Node2D
class_name NodeSTG

@onready var marker: = get_tree().get_first_node_in_group("Marker")

## 以多少度角为0度角
@export var ori_ang: float
## 速率曲线
@export var lin_curve: Curve = Curve.new()
## 角度曲线
@export var ang_curve: Curve = Curve.new()

# 自己消失后顶替自己的节点
#@export var next_nodestg: PackedScene = null

var tot_time: float = 0

var lin: float:
	get:
		return lin_curve.sample(tot_time)
var ang: float:
	get:
		return ang_curve.sample(tot_time) + ori_ang
func get_dir(a: float):
	return Vector2.from_angle(deg_to_rad(a))

func _physics_process(delta: float) -> void:
	if visible == false:
		return
	tot_time += delta
	global_position += get_dir(ang) * lin * delta

func delete():
	#if next_nodestg != null:
		#var nt: NodeSTG = next_nodestg.instantiate()
		#marker.add_child(nt)
		#nt.global_position = self.global_position
	queue_free()
