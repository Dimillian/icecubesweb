import VercelUI

struct TrendingPage: View {
  let statuses: [Status]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        ForEach(statuses) { status in
          VStack(alignment: .leading) {
            HStack {
              Image(status.account.avatar.absoluteString)
                .resizable()
                .frame(width: 28, height: 28)
                .cornerRadius(8)
              Text(status.account.username)
            }
            Text(status.content)
          }
        }
      }
      .padding(16)
    }
  }
}

@main
struct App: ExpressHandler {
  static func configure(router: Router) async throws {
    router
      .get("/trending", { _, _ in
        let statuses = await Self.fetchTrending()
        return TrendingPage(statuses: statuses)
      })
  }
  
  
  static func fetchTrending() async -> [Status] {
    do {
      let resp = try await fetch("https://mastodon.social/api/v1/trends/statuses")
      return try await resp.decode()
    } catch { 
      return []
    }
  }
}
