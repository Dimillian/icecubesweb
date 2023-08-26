import VercelUI
import Vercel

struct TrendingPage: View {
  @State var statuses: [Status] = []
  
  var body: some View {
    List(statuses) { status in
      VStack {
        Text(status.id)
        Text(status.content)
      }
    }
    .task {
      await fetchTrending()
    }
  }
  
  func fetchTrending() async {
    do {
      let resp = try await fetch("https://mastodon.social/api/v1/trends/statuses")
      statuses = try await resp.decode()
    } catch { }
  }
}

@main
struct App: ExpressHandler {
  static func configure(router: Vercel.Router) async throws {
    router
      .get("/trending", TrendingPage())
  }
}
