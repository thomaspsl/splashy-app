import SwiftUI

struct TopicView: View {
    let topic: UnsplashTopic

    @StateObject var topicState = TopicState()
    @State private var isSheetPresented = false
    @State private var selectedPicture: UnsplashPhoto?

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task { await topicState.fetchTopicPictures(id: topic.id) }
                }, label: { Text("Load photos for topic") })
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8) {
                        if let feedList = topicState.pictures {
                            ForEach(feedList) { picture in
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
                            ForEach(0..<12, id: \.self) { _ in
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
            .navigationTitle(topic.title)
            .sheet(item: $selectedPicture) { picture in
                DetailView(picture: picture)
            }
        }
    }
}
