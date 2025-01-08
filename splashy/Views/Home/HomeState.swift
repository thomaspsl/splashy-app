import Foundation
import Combine

@MainActor
class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?

    func fetchPictures() async {
        do {
            let request = URLRequest(url: feedUrl()!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            DispatchQueue.main.async {
                self.homeFeed = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
    
    func fetchTopics() async {
        do {
            let request = URLRequest(url: feedUrl()!)
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
