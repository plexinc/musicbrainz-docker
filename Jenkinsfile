@Library('plextools') import tv.plex.PlexTools

def tools = new PlexTools(this)
def dockerImage = 'plex/build-ops:latest'
def repo = tools.getRepoName()
def branch = tools.get_branch_name()
gitHash = ""

stage('Get GIT info') {
  tools.dockerNode("plex/build-ops:latest", "xsmall") {
    def gitInfo = checkout(tools.checkout_obj())
    gitHash = gitInfo.get('GIT_COMMIT')[0..6]
  }
}

stage('Build and push musicbrainz server') {
  tools.paasBuildandPushImage(
    repo: repo,
    dockerImageTag: "server-${branch}-${gitHash}",
    dockerFileDir: "musicbrainz-dockerfile"
  )
}
stage('Build and push musicbrainz indexer') {
  tools.paasBuildandPushImage(
    repo: repo,
    dockerImageTag: "indexer-${branch}-${gitHash}",
    dockerFileDir: "sir-dockerfile"
  )
}
stage('Build and push musicbrainz db') {
  tools.paasBuildandPushImage(
    repo: repo,
    dockerImageTag: "db-${branch}-${gitHash}",
    dockerFileDir: "postgres-dockerfile"
  )
}
stage('Build and push musicbrainz search') {
  tools.paasBuildandPushImage(
    repo: repo,
    dockerImageTag: "search-${branch}-${gitHash}",
    dockerFileDir: "solr-dockerfile"
  )
}
stage('Build and push musicbrainz rabbitMQ') {
  tools.paasBuildandPushImage(
    repo: repo,
    dockerImageTag: "rabbitmq-${branch}-${gitHash}",
    dockerFileDir: "rabbitmq-dockerfile"
  )
}
