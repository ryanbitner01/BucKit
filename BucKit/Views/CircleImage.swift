//
//  CircleImage.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import SwiftUI

// Used to make a circular image
struct CircleImage: View {
    let width: CGFloat
    let image: String?
    var imageURL: URL? {
        guard let image = image else {return nil}
        return URL(string: image)
    }
    
    var imageData: Data? {
        guard let url = imageURL else {return nil}
        return try? Data(contentsOf: url)
    }
    
    var uiImage: UIImage {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            return uiImage
        } else {
            return UIImage(named: "testImage")!
        }
    }
    var body: some View {
        
        Image(uiImage: uiImage)
            .resizable()
            .frame(width: width > 150 ? 150: width, height: width > 150 ? 150: width)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.primary, lineWidth: 1).shadow(radius: 50))
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage(width: 200, image: nil)
        }
    }
}

