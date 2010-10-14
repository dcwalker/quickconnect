require 'yaml'

module QuickConnect

  def self.get_database_config(database_yaml_path, environment = "development")
    YAML.load(File.read("#{database_yaml_path}")).fetch(environment)
  end

  def self.get_mysql_prompt(database_config)
    prompt = ["mysql"]
    prompt.push "--host=#{database_config["host"]}" if database_config["host"]
    prompt.push "--user=#{database_config["user"]}" if database_config["user"]
    prompt.push "--password=#{database_config["password"]}" if database_config["password"]
    prompt.push database_config["database"] if database_config["database"]
    return prompt.join(" ")
  end
end
