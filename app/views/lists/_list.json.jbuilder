json.extract! list, :id, :title, :description, :completed, :created_at, :updated_at
json.url list_url(list, format: :json)
