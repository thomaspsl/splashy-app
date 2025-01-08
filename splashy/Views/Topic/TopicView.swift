import SwiftUI

struct FeedView: View {
    @StateObject var feedState = FeedState()
        
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task {
                        await feedState.fetchHomeFeed()
                    }
                }, label: {
                    Text("Load...")
                })
//              ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem()], spacing: 8) {
                    ForEach(0..<3) { _ in
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
                .padding(.horizontal, 8)
//              }
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 8) {
                        if let feedList = feedState.homeFeed {
                            ForEach(feedList) { picture in
                                AsyncImage(url: URL(string: picture.urls.small)) { image in
                                    image
                                        .resizable()
                                        .frame(height: 150)
                                        .cornerRadius(12)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color(hex: picture.color).opacity(0.3))
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
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedView()
}
