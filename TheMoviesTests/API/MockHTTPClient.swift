//
//  MockHTTPClient.swift
//  TheMoviesTests
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation
@testable import TheMovies

class MockHTTPClient: HTTPClientSerivce {
    
    func dataTask(urlRequest: URLRequest, completion: @escaping ((Result<Data, APIError>) -> Void)) {
        switch urlRequest.url?.path {
        case MovieRoute.popularMovies.url.path:
            if urlRequest.url?.query?.contains("page=1") ?? false {
                let bundle = Bundle(for: type(of: self))
                let fileUrl = bundle.url(forResource: "PopularMovies", withExtension: "json")!
                let data = try! Data(contentsOf: fileUrl)
                completion(Result.success(data))
            } else if urlRequest.url?.query?.contains("page=2") ?? false {
                let bundle = Bundle(for: type(of: self))
                let fileUrl = bundle.url(forResource: "PopularMoviesEmpty", withExtension: "json")!
                let data = try! Data(contentsOf: fileUrl)
                completion(Result.success(data))
            }else {
                let data = "".data(using: .utf8)
                completion(Result.success(data!))
            }
            break
            
        default:
            completion(Result.failure(APIError.invalidRequestURL(urlRequest.url!)))
            break
        }
    }
    
    func downloadTask(url: String, completion: @escaping ((Result<URL, APIError>) -> Void)) {
        
    }
    
    func cancel() {
        
    }
    
    
    
    
    
}
