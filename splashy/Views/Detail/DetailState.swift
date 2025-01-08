import Foundation
import Combine

@MainActor
class DetailState: ObservableObject {
    @Published var picture: UnsplashPhoto?

    func fetchPicture(id: String) async {
        do {
            let request = URLRequest(url: pictureUrl(id: id)!)
            let (data, _) = try await URLSession.shared.data(for: request)
            let deserializedData = try JSONDecoder().decode(UnsplashPhoto.self, from: data)
            
            DispatchQueue.main.async {
                self.picture = deserializedData
            }
        } catch {
            print("Error fetching feed: \(error)")
        }
    }
}
