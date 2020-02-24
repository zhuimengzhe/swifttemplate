//
//  ExtImage.swift
//  MySwiftTemplate
//
//  Created by apple on 29/11/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit
extension UIImage {
    func resizeImage(_ image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    func data() -> Data {
        var imageData = self.pngData()
        
        // Resize the image if it exceeds the 2MB API limit
        if (imageData?.count)! > 2097152 {
            let oldSize = self.size
            let newSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            let newImage = self.resizeImage(self, size: newSize)
            imageData = newImage.jpegData(compressionQuality: 0.7)
        }
        
        return imageData!
    }
    
    func base64EncodedString() -> String {
        let imageData = self.data()
        let stringData = imageData.base64EncodedString(options: .endLineWithCarriageReturn)
        return stringData
    }
    
    func base64String() -> String? {
        return self.pngData()?.base64EncodedString()
    }
}
