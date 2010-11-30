require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "QuickConnect" do

  context ".get_database_config" do
    before(:each) do
      yaml = mock("YAML")
      yaml.stub!(:fetch).and_return({:database => "configured"})
      YAML.stub!(:load).and_return yaml
    end
    it "should provide a nice error message if the database config can't be found"
    it "should provide a nice error message if the environment is not known"
    it "should read options from the config provided" do
      File.should_receive(:read).with("path").and_return true
      QuickConnect.get_database_config("path", "environment")
    end
    it "should return a hash of config options" do
      File.stub!(:read).and_return true
      QuickConnect.get_database_config("path", "environment").should == {:database => "configured"}
    end
  end

  context ".get_mysql_prompt" do
    it "should begin with 'mysql'" do
      QuickConnect.get_mysql_prompt("configuration").should match(/^mysql/)
    end

    it "should include the prompt options from the provided configuration" do
      QuickConnect.should_receive(:get_mysql_connect_options).with("configuration").and_return("options")
      QuickConnect.get_mysql_prompt("configuration").should match(/^mysql options/)
    end
  end

  context ".get_mysql_connect_options" do
    it "should include a host option if provided" do
      QuickConnect.get_mysql_connect_options({"host" => "dbhost"}).should match(/--host=dbhost/)
    end
    it "should include a user option if provided" do
      QuickConnect.get_mysql_connect_options({"user" => "dbuser"}).should match(/--user=dbuser/)
    end
    it "should include a password option if provided" do
      QuickConnect.get_mysql_connect_options({"password" => "dbpassword"}).should match(/--password=dbpassword/)
    end
    it "should append the database name" do
      QuickConnect.get_mysql_connect_options({"database" => "dbname"}).should match(/dbname$/)
    end
  end
end
