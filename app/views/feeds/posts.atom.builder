atom_feed({
  'xmlns:app' => 'http://w3.org/2007/app',
  'xmlns:opensearch' => 'http://a9.com/-/spec/opensearch/1.1/'
}) do |feed|
  feed.title("BlogApp")
  feed.updated(@posts.first.created_at)
  
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content post.body
      entry.author do |author|
        author.name post.user.name
      end

    end
  end
end
