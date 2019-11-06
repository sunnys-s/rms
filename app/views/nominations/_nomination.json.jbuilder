json.extract! nomination, :id, :award_id, :nomination_type, :created_at, :updated_at
json.url nomination_url(nomination, format: :json)
