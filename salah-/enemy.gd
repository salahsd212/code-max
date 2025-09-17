extends CharacterBody3D

@export var gravity = -10
@export var speed: float = 2.0 # سرعة العدو، يمكنك تعديلها من محرر Godot

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: CharacterBody3D = %player # يفترض أن لديك alias (اسم مستعار) للعقدة الخاصة باللاعب باسم "player"
@onready var animation_player: AnimationPlayer = $holder/AnimationPlayer

var target_player: CharacterBody3D = null # اللاعب الذي يتبعه العدو حالياً

func _ready() -> void:
	# تشغيل حركة الـ mixamo_com عند بدء المشهد
	if animation_player:
		animation_player.play("mixamo_com")
	
	# تعيين اللاعب المستهدف عند البدء إذا كان موجودًا
	if player:
		target_player = player

func _physics_process(delta):
	# الخطوة 1: التأكد من وجود لاعب مستهدف
	# إذا كنت تستخدم %player، فإنه يتم تعيينه مرة واحدة في _ready.
	# إذا كان اللاعبون يظهرون أو يختفون، فقد تحتاج إلى إعادة البحث عنهم.
	if target_player:
		# الخطوة 2: حساب الاتجاه من العدو إلى اللاعب
		var direction = (target_player.global_position - global_position).normalized()
		
		# الخطوة 3: تحديد سرعة العدو في هذا الاتجاه
		velocity = direction * speed

		# --- الإضافة الجديدة: جعل العدو ينظر إلى اللاعب ---
		# إنشاء متجه هدف للنظر إليه.
		# الأهم هو الحفاظ على مستوى Y الخاص بالعدو لمنعه من الميلان لأعلى أو لأسفل.
		var target_look_at = target_player.global_position
		target_look_at.y = global_position.y # اجعل العدو ينظر فقط على المحور الأفقي (Y)
		
		# استخدام دالة look_at لجعل العدو يواجه الهدف
		look_at(target_look_at, Vector3.UP)
		# --------------------------------------------------

		# الخطوة 4: تطبيق الحركة
		move_and_slide()
	else:
		# إذا لم يكن هناك لاعب مستهدف، اجعل العدو يتوقف
		velocity = Vector3.ZERO
		move_and_slide()

# دالة للبحث عن أقرب لاعب (محتفظ بها كما هي في حال أردت استخدامها)
# إذا كنت تعتمد على %player بشكل ثابت، فقد لا تحتاج إلى استدعاء هذه الدالة في كل إطار.
func find_closest_player():
	var closest_dist = INF # قيمة كبيرة جداً للمقارنة
	var current_closest_player = null

	# تكرار على جميع العقد في مجموعة "players"
	for player_node in get_tree().get_nodes_in_group("player"):
		if player_node is CharacterBody3D:
			var dist = global_position.distance_to(player_node.global_position)
			if dist < closest_dist:
				closest_dist = dist
				current_closest_player = player_node

	target_player = current_closest_player
