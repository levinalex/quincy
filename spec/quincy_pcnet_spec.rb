require 'helper'

describe "With Patdat-Files in the current directory" do
  before do
    @q = Quincy::PCnet.new('.')
  end

  specify "file for patient 0 should be PATDAT00/0000.DAT" do
    @q.path_for(0).should == "PATDAT00/0000.DAT"
  end
  specify "file for patient 98 should be PATDAT00/0098.DAT" do
    @q.path_for(98).should == "PATDAT00/0098.DAT"
  end
  specify "file for patient 128 should be PATDAT00/0098.DAT" do
    @q.path_for(128).should == "PATDAT01/0128.DAT"
  end
  specify "file for patient 19237 should be PATDAT10/1317.DAT" do
    @q.path_for(19237).should == "PATDAT10/1317.DAT"
  end
end

describe "generated path to the patdat files" do
  specify "absolute pahs should be preserved" do
    @q = Quincy::PCnet.new("/absolute/path")
    @q.path_for(300).should == "/absolute/path/PATDAT02/0300.DAT"
  end
end

describe "reading of patients" do
  before do
    @q = Quincy::PCnet.new( File.dirname(__FILE__) + "/sample")
  end

  specify "name of patient 98 should be Sierra, Rudolph" do
    patient = @q.find(98)
    patient.name.should == ("Sierra, Rudolph")
    patient.nr.should be_equal(98)
  end

  specify "searching for nonexistent patient should return nil" do
    @q.find(140898).should be_nil
    @q.find(12345).should be_nil
  end
end

describe "when ENV['QUINCY'] is set" do
  before do
    ENV["QUINCY"] = "/some/path"
  end

  specify "path should default to this value" do
    Quincy::PCnet.new.quincy_path.to_s.should == "/some/path"
  end

  specify "Path should be taken from ENV even if Quincy is constructed with 'nil' as argument" do
    Quincy::PCnet.new(nil).quincy_path.to_s.should == "/some/path"
  end

end

describe "when ENV['QUINCY'] is not set" do
  before do
    ENV["QUINCY"] = nil
  end

  specify "PCnet should raise an error if it is constructed without an argument" do
    lambda { @q = Quincy::PCnet.new() }.should raise_error(ArgumentError)
  end
end

