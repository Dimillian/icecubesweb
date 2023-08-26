import Foundation

struct Account: Codable, Identifiable {
  let id: String
  let username: String
  let displayName: String?
  let avatar: URL
}
