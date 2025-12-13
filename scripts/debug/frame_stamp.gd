extends Label

# STAMP ALL FRAMES WITH PROJECT NAME AND VERSIONS


func _ready() -> void:
	# Get the project name
	var project_name: String = ProjectSettings.get_setting("application/config/name")
	
	# Get the user-defined version in ProjectSettings → application/config/version
	var project_version: String = ProjectSettings.get_setting("application/config/version")
	
	# Display both in the Label
	text = "%s | v%s" % [project_name, project_version]