extends Label

var credit_text = [
	"Credits\nDeveloped by:\n\"WereWaffles Studio\"",
	"Art by:\nDevan Mapp\nDavid Swanstrom",
	"Development by:\nDevan Mapp\nDavid Swanstrom",
	"Music by:\nJames Ferro"
]

var thanks = "Thank You For Playing Ekliptis!"

func _ready():
	var arr_length = credit_text.size()
	var current_text = 0
	
	while current_text < arr_length:
		print(credit_text[current_text])
		text_scroll(credit_text[current_text])
		current_text += 1
		await get_tree().create_timer(7.5).timeout
		
	text_scroll(thanks)
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
	
func text_scroll(input_text: String) -> void:
	visible_characters = 0
	text = input_text
	
	for i in text.length():
		visible_characters += 1
		await get_tree().create_timer(0.1).timeout



