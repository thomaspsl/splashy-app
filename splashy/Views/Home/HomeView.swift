import UnifiedBlurHash
import SwiftUI

struct HomeView: View {
    @StateObject var homeState = HomeState()
    @State private var isSheetPresented = false
    @State private var selectedPicture: UnsplashPhoto?
        
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task {
                        await homeState.fetchPictures()
                        await homeState.fetchTopics()
                    }
                }, label: { Text("Load...") })
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem()], spacing: 8) {
                        if let topicsList = homeState.topics {
                            ForEach(topicsList) { topic in
                                NavigationLink(destination: TopicView(topic: topic)) {
                                    VStack(spacing: 8) {
                                        AsyncImage(url: URL(string: topic.cover_photo.urls.small)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Image(blurHash: topic.cover_photo.blur_hash)?.resizable()
                                        }
                                        .frame(width: 120, height: 80)
                                        .cornerRadius(12)
                                        
                                        Text(topic.title)
                                            .font(.system(size: 11))
                                    }
                                }
                            }
                        } else {
                            ForEach(0..<10) { _ in
                                VStack(spacing: 8) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 120, height: 80)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 80, height: 12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 140)
                }
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8) {
                        if let picturesList = homeState.pictures {
                            ForEach(picturesList) { picture in
                                Button(action: {
                                    selectedPicture = picture
                                    isSheetPresented = true
                                }) {
                                    AsyncImage(url: URL(string: picture.urls.small)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Image(blurHash: picture.blur_hash)?.resizable()
                                    }
                                    .frame(height: 150)
                                    .cornerRadius(12)
                                }
                            }
                        } else {
                            ForEach(0..<10, id: \.self) { _ in
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .navigationTitle("Feed")
            .sheet(item: $selectedPicture) { picture in
                DetailView(picture: picture)
            }
        }
    }
}
