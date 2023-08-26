import Foundation

struct MediaAttachment: Codable, Identifiable {
  public let id: String
  public let url: URL?
}
