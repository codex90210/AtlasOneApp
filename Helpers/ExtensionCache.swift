//
//  ExtensionCache.swift
//  PremioBeta
//
//  Created by David Mompoint on 11/10/19.
//  Copyright © 2019 ATLASONE. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadCacheImageURL(urlString: String) {
        
        self.image = nil
        
        //CHECK FOR CACHE IMAGE FIRST
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        //OTHERWISE FIRE OFF A NEW DOWNLOAD
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in

            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                     self.image = downloadedImage
                }
            }

        }).resume()
    }
}
