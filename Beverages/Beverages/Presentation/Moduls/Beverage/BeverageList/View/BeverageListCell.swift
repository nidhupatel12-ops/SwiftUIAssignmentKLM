
import SwiftUI
import Foundation
import UIKit

struct BeverageListCell: View {
    var beverage: BeverageDTO
    
    @State private var image: UIImage?
    
    var body: some View {
        HStack {
            let imageURL =  URL(string: beverage.image)
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }else {
                    ProgressView()
                }
            }.frame(width: 80, height: 80)
            .clipped()
            .cornerRadius(8)
            .task(id : imageURL) {
                image = await ImageCache.shared.getImageURL(url: imageURL!)
            }
            
            VStack(alignment: .leading) {
                Text(beverage.wine)
                    .font(.headline)
                
                Text(beverage.winery)
                    .font(.subheadline)
                RatingView(beverage: beverage)
            }
        }
        .padding(.vertical,8)
    }
}


