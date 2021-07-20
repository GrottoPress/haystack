require "spec"
require "webmock"

require "../src/haystack"
require "./support/**"

Spec.before_each do
  WebMock.reset
end
