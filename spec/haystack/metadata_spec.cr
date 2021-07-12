require "../spec_helper"

describe Haystack::Metadata do
  describe ".from_any" do
    it "returns metadata unmodified" do
      action = "action"
      metadata = Haystack::Metadata.from_json(%({"cancel_action": "#{action}"}))
      metadata = Haystack::Metadata.from_any(metadata)

      metadata.should be_a(Haystack::Metadata)
      metadata.try(&.cancel_action).should eq(action)
    end

    it "returns metadata from scalar" do
      id = 44
      metadata = Haystack::Metadata.from_any(id)

      metadata.should be_a(Haystack::Metadata)
      metadata.try(&.any).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Metadata.from_any(nil).should be_nil
    end

    it "is parsed correctly as JSON attribute" do
      invoice = Haystack::Invoice.from_json(%({
        "metadata": {"cancel_action": "abc", "other": "other"}
      }))

      invoice.metadata.try(&.cancel_action).should eq("abc")
      invoice.metadata.try(&.json_unmapped["other"]).should eq("other")

      transaction = Haystack::Invoice.from_json(%({"metadata": [1, 2, 3]}))
      transaction.metadata.try(&.any).should eq([1, 2, 3])
    end
  end
end
