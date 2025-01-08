import Foundation
import Combine

@MainActor
class HomeState: ObservableObject {
    @Published var pictures: [UnsplashPhoto]?
    @Published var topics: [UnsplashTopic]?

    func fetchPictures() async {
        do {
            let request = URLRequest(url: picturesUrl()!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            DispatchQueue.main.async {
                self.pictures = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
    
    func fetchTopics() async {
        do {
            let request = URLRequest(url: topicsUrl()!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashTopic].self, from: data)
            
            DispatchQueue.main.async {
                self.topics = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
}
