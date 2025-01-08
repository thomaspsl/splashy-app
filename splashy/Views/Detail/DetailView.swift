import UnifiedBlurHash
import PhotosUI
import SwiftUI

struct DetailView: View {
    let picture: UnsplashPhoto
    
    @State private var selectedOption = "Regular"
    @State private var isSaving = false
    @State private var saveSuccess = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Picker("Options", selection: $selectedOption) {
                    Text("Regular").tag("Regular")
                    Text("Full").tag("Full")
                    Text("Small").tag("Small")
                }
                .pickerStyle(.segmented)
                .padding()
                
                AsyncImage(url: imageUrl(for: selectedOption)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(blurHash: picture.blur_hash)?.resizable()
                        .scaledToFit()
                }
                .frame(height: 500)
                .cornerRadius(12)
                .padding()
                
                Spacer()
                
                Button(action: {
                    if let url = imageUrl(for: selectedOption) {
                        downloadImage(from: url)
                    }
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Télécharger")
                    }
                    .font(.headline)
                }
                .padding()
                .disabled(saveSuccess)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Text("Une image de ")
                            .font(.headline)
                        
                        Link(destination: userUrl(username: picture.user.username)!) {
                            Text("@\(picture.user.username)")
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
    
    private func imageUrl(for option: String) -> URL? {
        switch option {
        case "Regular":
            return URL(string: picture.urls.regular)
        case "Full":
            return URL(string: picture.urls.full)
        case "Small":
            return URL(string: picture.urls.small)
        default:
            return nil
        }
    }
    
    private func downloadImage(from url: URL) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            } catch {
                print("Erreur lors du téléchargement de l'image : \(error)")
            }
        }
    }
}
