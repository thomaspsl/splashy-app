struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let user: User
    let blur_hash: String
    let urls: UnsplashPhotoUrls
}

struct UnsplashTopic: Codable, Identifiable {
    let id: String
    let slug: String
    let title: String
    let cover_photo: UnsplashPhoto
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
