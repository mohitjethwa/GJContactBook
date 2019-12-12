//
//  GJImageView.swift
//  GJContactBook
//
//  Created by Mohit Jethwa on 12/12/19.
//  Copyright © 2019 Mohit Jethwa. All rights reserved.
//

import UIKit

class GJImageView: UIImageView {
    
    var session: URLSessionDataTask?
    static var cache: NSCache<NSString, AnyObject> = NSCache<NSString, AnyObject>()
    
    func loadImage(url: String,placeHolder: UIImage?,  callback: @escaping(_ sucess: Bool) -> Void) {
        if let session = session {
            session.cancel()
        }
        if let obj = GJImageView.cache.object(forKey: url as NSString) as? UIImage {
            self.image = obj
            callback(true)
        } else {
            self.image = placeHolder
            if let url = URL(string: url) {
                self.loadImageFromAPI(url: url, callback: callback)
            }
            
        }
        
    }
    
    private func loadImageFromAPI(url: URL, callback: @escaping(_ sucess: Bool) -> Void) {
        self.session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    callback(false)
                    return
                    
            }
            callback(true)
            GJImageView.cache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }
        self.session?.resume()
    }
    
}
