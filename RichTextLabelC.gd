extends RichTextLabel

# Variables
var dialog = [
	"[color=red]???[/color]: \nWelcome traveler",
	"I don't think you can enter alone there a two man door inside",
	"I can help with that"]
var page = 0

# Functions
func _ready():
	set_process_input(true)
	set_bbcode(dialog[page])
	set_visible_characters(0)

func _input(event):
	if Input.is_key_pressed(KEY_B) && event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
			else:
				$"..".visible = false
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
