
import UIKit
import SwiftUI

final class ImageCache {
    static let shared = ImageCache()
    private init() {}
    private var cache = NSCache<NSURL, UIImage>()
    
    func image(for url : NSURL) -> UIImage? {
        cache.object(forKey: url)
    }
    
    func insert(_ image : UIImage, for url : NSURL) {
        cache.setObject(image, forKey: url)
    }
    
    func getImageURL(url : URL) async -> UIImage? {
        
        let nsURL = url as NSURL
    
        //cache first
        if let cached = self.image(for: nsURL) {
            return cached
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.insert(image, for: nsURL)
            return image
        } catch {
            print("image download error: \(error)")
            return UIImage(named: "Photo")
        }
    }
}


