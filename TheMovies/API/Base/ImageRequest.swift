//
//  ImageRequest.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation
import UIKit

class ImageRequest {
    
    private var httpClient: HTTPClientSerivce!
    
    init() {
        httpClient = HTTPClient()
    }
    
    public func download(url: String, completion: @escaping (String, UIImage?) -> Void) {
        httpClient.downloadTask(url: url) { (result) in
            switch result {
            case .success(let response):
                if let data = try? Data(contentsOf: response), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(url, image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(url, nil)
                    }
                }
                break
                
            case .failure(_):
                DispatchQueue.main.async {
                    completion(url, nil)
                }

                break
            }
        }
    }
    
}
