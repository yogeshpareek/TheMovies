//
//  ImageDownloadOperation.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class ImageDownloadOperation: Operation {
    
    private let request: ImageRequest
    private var downloadTask: URLSessionTask?
    
    public var downloadCompletionHandler: ImageDownloadManager.ImageDownloadHandler?

    private(set) var imagePath: String
    private let size: CGSize
    private let indexPath: IndexPath?
    
    init(url: String, size: CGSize, indexPath: IndexPath?) {
        self.imagePath = url
        self.size = size
        self.indexPath = indexPath
        request = ImageRequest()
    }
    
    override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        executing(true)
        download()
    }
    
    override func cancel() {
        request.cancel()
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    private var _executing: Bool = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private func executing(_ executing: Bool) {
        _executing = executing
    }
    
    private func finish(_ finished: Bool) {
        _finished = finished
    }
    
    private func download() {
        request.download(url: imagePath) { [weak self] (location, image, error) in
            self?.completed(image: image, error: error)
            self?.finish(true)
            self?.executing(false)
        }
    }
    
    private func completed(image: UIImage?, error: Error?) {
        self.downloadCompletionHandler?(image, imagePath, indexPath, error as? APIError)
    }
    
}
