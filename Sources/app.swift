import VercelUI

struct TrendingPage: View {
  let statuses: [Status]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text("Trends on Mastodon.social")
          .font(.title)
        
        ForEach(statuses) { status in
          VStack(alignment: .leading) {
            HStack(alignment: .center) {
              Image(status.account.avatar.absoluteString)
                .resizable()
                .frame(width: 28, height: 28)
                .cornerRadius(8)
              Text(status.account.username)
                .font(.headline)
              if let acct = status.account.acct {
                Text(acct)
                  .font(.footnote)
                  .foregroundColor(.gray)
              }
            }
            
            HTML("div", content: status.content)
            
            if let mediaURL = status.media_attachments.first?.url {
              Image(mediaURL.absoluteString)
                .resizable()
                .frame(maxWidth: 400)
            }
             
            if let url = status.url {
              Link("See more", destination: url)
                .font(.footnote)
                .foregroundColor(.blue)
            }
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
