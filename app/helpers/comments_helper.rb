module CommentsHelper
  def commentable_type commentable
    commentable.class.name.downcase
  end
end
