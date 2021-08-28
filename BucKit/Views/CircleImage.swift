//
//  CircleImage.swift
//  BucKit
//
//  Created by Ryan Bitner on 8/27/21.
//

import SwiftUI

struct CircleImage: View {
    let height: CGFloat
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
            .frame(minWidth: height * 0.85 ,maxWidth: height, minHeight: height * 0.85 ,maxHeight: height)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.primary, lineWidth: 1).shadow(radius: 50))
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage(height: 200, image: nil)
            CircleImage(height: 200, image: nil)
        }
    }
}
