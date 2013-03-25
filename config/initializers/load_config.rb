conference_config = YAML.load_file("#{Rails.root}/config/custom/conference.yml")
DictyConfig = OpenStruct.new(conference_config)

mapping_config = YAML.load_file("#{Rails.root}/config/custom/menu-controller.yml")
ActionMap = OpenStruct.new(mapping_config)
