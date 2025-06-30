json.extract! photo, :id, :title, :user_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)
