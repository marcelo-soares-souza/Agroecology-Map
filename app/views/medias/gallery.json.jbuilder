# frozen_string_literal: true

json.gallery do
  json.array!(@medias) do |media|
    json.id media.id
    json.description media.description
    json.image_url photo_thumb_url(media)
    json.account_id media.account_id
    json.created_at media.created_at
    json.updated_at media.updated_at
  end
end
