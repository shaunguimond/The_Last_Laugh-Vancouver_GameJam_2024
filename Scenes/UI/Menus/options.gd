extends Control

var getBorderless = ProjectSettings.get_setting_with_override("display/window/size/mode")

func _on_borderless_pressed():
	if getBorderless == 0:
		print(ProjectSettings.get_setting_with_override("display/window/size/mode"))
		ProjectSettings.set_setting("display/window/size/mode", 3) 
	else :
		print(ProjectSettings.get_setting_with_override("display/window/size/mode"))
		ProjectSettings.set_setting("display/window/size/mode", 0) 
