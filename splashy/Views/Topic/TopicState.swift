import Foundation
import Combine

@MainActor
class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]? = nil

    func fetchHomeFeed() async {
        do {
            let request = URLRequest(url: feedUrl(orderBy: "random")!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            DispatchQueue.main.async {
                self.homeFeed = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
}
