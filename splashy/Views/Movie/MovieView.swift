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
                "title": "Inception",
                "releaseYear": 2010,
                "genre": "Sci-Fi"
            },
            {
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

