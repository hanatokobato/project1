module RelationshipsHelper
  def follow_form_data
    current_user.active_relationships.build
  end

  def unfollow_form_data user
    current_user.active_relationships.find_by followed_id: user.id
  end
end
