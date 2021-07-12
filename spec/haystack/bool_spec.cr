require "../spec_helper"

describe Haystack::Bool do
  describe ".from_any" do
    it "returns bool unmodified" do
      Haystack::Bool.from_any(true).should be_true
      Haystack::Bool.from_any(false).should be_false
    end

    it "returns bool from number" do
      Haystack::Bool.from_any(44).should be_true
      Haystack::Bool.from_any(44.4).should be_true
      Haystack::Bool.from_any(0).should be_false
      Haystack::Bool.from_any(0.0).should be_false
    end

    it "returns bool from string" do
      Haystack::Bool.from_any("abc").should be_true
      Haystack::Bool.from_any("12").should be_true
      Haystack::Bool.from_any("0").should be_false
      Haystack::Bool.from_any("").should be_false
    end

    it "returns nil from nil" do
      Haystack::Bool.from_any(nil).should be_nil
    end
  end
end
