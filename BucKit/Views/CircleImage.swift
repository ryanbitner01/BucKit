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
    var imageData: Data?
    
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
            .frame(width: width > 150 ? 150: width, height: width > 150 ? 150: width, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.primary, lineWidth: 1).shadow(radius: 50))
            
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage(width: 50, imageData: nil)
        }
    }
}

extension UIImage {
    
    func resizedRoundedImage() -> UIImage {
        let size: CGFloat = 50
        let imageView: UIImageView = UIImageView(image: self)
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: size, height: size))
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = size / 2
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }

}
