import Foundation

struct Movie: Codable, Identifiable {
    var id = UUID()
    let title: String
    let releaseYear: Int
    let genre: String
    let director: String?
}
