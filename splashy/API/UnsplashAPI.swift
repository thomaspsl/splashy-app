import Foundation

func unsplashAppBaseUrl() -> URLComponents {
    return URLComponents(string: "https://www.unsplash.com")!
}

func unsplashApiBaseUrl() -> URLComponents {
    var components = URLComponents(string: "https://api.unsplash.com")!
    components.queryItems = [
        URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
    ]
    return components
}

func picturesUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = "/photos"
    components.queryItems?.append(contentsOf: [
        URLQueryItem(name: "order_by", value: orderBy),
        URLQueryItem(name: "per_page", value: "\(perPage)")
    ])
    return components.url
}

func pictureUrl(id: String) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = "/photos/\(id)"
    return components.url
}

func topicsUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = "/topics"
    components.queryItems?.append(contentsOf: [
        URLQueryItem(name: "order_by", value: orderBy),
        URLQueryItem(name: "per_page", value: "\(perPage)")
    ])
    return components.url
}

func topicsPicturesUrl(id: String, orderBy: String = "popular", perPage: Int = 10) -> URL? {
    var components = unsplashApiBaseUrl()
    components.path = "/topics/\(id)/photos"
    components.queryItems?.append(contentsOf: [
        URLQueryItem(name: "order_by", value: orderBy),
        URLQueryItem(name: "per_page", value: "\(perPage)")
    ])
    return components.url
}

func userUrl(username: String) -> URL? {
    var components = unsplashAppBaseUrl()
    components.path = "/\(username)"
    return components.url
}
