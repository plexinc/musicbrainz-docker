@Library('plextools@cookandy/fix-paasBuildandPushImage2') import tv.plex.PlexTools

def tools = new PlexTools(this)

def repo = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]

node('plex-linux-x86_64') {
  tools.uniqueWS(project: repo) {
    stage('Checkout') {
      gitInfo = checkout(tools.checkout_obj())
      gitHash = gitInfo.get('GIT_COMMIT')[0..6]
      branch = tools.get_branch_name()
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
  }
}
