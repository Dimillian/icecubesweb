import Foundation

struct Status: Codable, Identifiable {
  let id: String
  let content: String
  let account: Account
  let url: URL?
}
