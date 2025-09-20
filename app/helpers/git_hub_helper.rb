module GitHubHelper
  def view_on_github_url(path, branch: "main")
    username = ENV.fetch("GITHUB_USERNAME", "Rails-Designer")
    repository = ENV.fetch("GITHUB_REPOSITORY", "perron-site")

    "https://github.com/#{username}/#{repository}/blob/#{branch}/#{path}"
  end

  def edit_on_github_url(resource, branch: "main")
    username = ENV.fetch("GITHUB_USERNAME", "Rails-Designer")
    repository = ENV.fetch("GITHUB_REPOSITORY", "perron-site")
    path = Pathname.new(resource.file_path).relative_path_from(Rails.root)

    "https://github.com/#{username}/#{repository}/edit/#{branch}/#{path}"
  end
end
