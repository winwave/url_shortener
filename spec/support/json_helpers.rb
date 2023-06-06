# frozen_string_literal: true

def body_as_json
  JSON.parse(response.body)
end
