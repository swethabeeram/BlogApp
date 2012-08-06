atom_feed({
  'xmlns:app' => 'http://w3.org/2007/app',
  'xmlns:opensearch' => 'http://a9.com/-/spec/opensearch/1.1/'
}) do |feed|
  feed.title("BlogApp")
  feed.updated(@comments.first.created_at)if
  @post.comments.any?
  @comments.each do |comment|
    feed.entry(@post) do |entry|
      entry.title "#{@post.title} - Reply by #{comment.user.name}"
      entry.content comment.comment
      entry.author do |author|
        author.name comment.user.name
      end

    end
  end
end
