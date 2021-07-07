require "spec"
require "webmock"
require "../src/haystack"

Spec.before_each do
  WebMock.reset
end
