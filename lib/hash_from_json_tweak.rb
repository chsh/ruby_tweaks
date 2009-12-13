
def Hash.from_json(json)
  h = ActiveSupport::JSON.decode json
  raise 'Parse result must be Hash.' unless h.is_a? Hash
  h
end
