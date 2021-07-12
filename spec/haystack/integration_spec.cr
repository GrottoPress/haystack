require "../spec_helper"

describe Haystack::Integration do
  describe ".from_any" do
    it "returns integration unmodified" do
      id = 11
      integration = Haystack::Integration.from_json(%({"id": #{id}}))
      integration = Haystack::Integration.from_any(integration)

      integration.should be_a(Haystack::Integration)
      integration.try(&.id).should eq(id)
    end

    it "returns integration from integer" do
      id = 44
      integration = Haystack::Integration.from_any(id)

      integration.should be_a(Haystack::Integration)
      integration.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Integration.from_any(nil).should be_nil
    end
  end
end
