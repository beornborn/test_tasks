require_relative '../spec_helper'

describe Dictionary do
  it "should set entries right" do
    allow(File).to receive(:readlines).and_return(["AA explanation one", "AB explanation two"])
    dictionary = Dictionary.new "example.txt"
    dictionary.entries.should == [
      { word: "AA", explanation: "explanation one" },
      { word: "AB", explanation: "explanation two" },
    ]
  end
end
