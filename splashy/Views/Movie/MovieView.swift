import SwiftUI

struct MovieView: View {
    @State private var movies: [Movie] = []
    
    var body: some View {
        NavigationView {
            List(movies) { movie in
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    
                    Text("Année de sortie : \(movie.releaseYear)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Genre : \(movie.genre)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if let director = movie.director {
                        Text("Réalisateur : \(director)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Films")
            .onAppear {
                loadMovies()
            }
        }
    }
    
    private func loadMovies() {
        let jsonString = """
        [
            {
                "id": "be60d0db-0cbf-425e-8001-c307f778ca1c",
                "title": "Inception",
                "releaseYear": 2010,
                "genre": "Sci-Fi",
                "director": "Christopher Nolan"
            },
            {
                "id": "7f9825bc-fb0b-4dd2-8aec-ec7715587e9b",
                "title": "The Dark Knight",
                "releaseYear": 2008,
                "genre": "Action"
            }
        ]
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let decodedMovies = try JSONDecoder().decode([Movie].self, from: jsonData)
                self.movies = decodedMovies
            } catch {
                print("Erreur de décodage : \(error)")
            }
        }
    }
}

#Preview {
    MovieView()
}

