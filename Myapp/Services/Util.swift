import Foundation
import UIKit
import SwiftUI

final class Util {
    
    private static let baseUrl: String = ""
    
    // fetch some Decodable T from a given URL
    static func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        let urlString = baseUrl + endpoint
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // The second return value is a URLResponse
        let(data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        
        return result;
    }
    
    // Load json file
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't file \(filename) in main bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
}

// Extension method example
extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self.resizable()
    }
}
