import Foundation
import Combine

@MainActor
class TopicState: ObservableObject {
    @Published var pictures: [UnsplashPhoto]?
    
    func fetchTopicPictures(id: String) async {
        do {
            let request = URLRequest(url: topicsPicturesUrl(id: id)!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
            
            DispatchQueue.main.async {
                self.pictures = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
}
