//
//  UIImage+Ext.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

private var imageURLKey: Void?

extension UIImageView {
    
    private var imageURL: String? {
        get {
            return objc_getAssociatedObject(self, &imageURLKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &imageURLKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
    
    func load(url: String, indexPath: IndexPath) {
        if let previousURL = imageURL {
            ImageDownloadManager.shared.changeDownloadPriorityToSlow(of: previousURL)
        }
        imageURL = url
        ImageDownloadManager.shared.download(url: url, indexPath: indexPath, size: self.frame.size) { [weak self](image, url, indexPathh, error) in
            DispatchQueue.main.async {
                if let strongSelf = self, let _image = image, let _path = strongSelf.imageURL, _path == url {
                    strongSelf.imageURL = nil
                    strongSelf.image = _image
                }
            }
        }
    }
    
    func load(url: String) {
        ImageDownloadManager.shared.download(url: url, indexPath: nil, size: self.frame.size) { (image, url, indexPathh, error) in
            if let _image = image {
                DispatchQueue.main.async {
                    self.image = _image
                }
            }
        }
    }
    
    func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage? {
        return image.resizedImageWith(image: image, targetSize: targetSize)
    }
    
}

extension UIImage {
    
    func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage? {
        let imageSize = image.size
        let newWidth  = targetSize.width  / image.size.width
        let newHeight = targetSize.height / image.size.height
        var newSize: CGSize
        
        if(newWidth > newHeight) {
            newSize = CGSize(width: imageSize.width * newHeight, height: imageSize.height * newHeight)
        } else {
            newSize = CGSize(width: imageSize.width * newWidth,  height: imageSize.height * newWidth)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
