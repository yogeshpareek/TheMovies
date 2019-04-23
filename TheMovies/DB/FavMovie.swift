//
//  FavMovie+CoreDataClass.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 22/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavMovie)
public class FavMovie: NSManagedObject {

}

extension FavMovie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavMovie> {
        return NSFetchRequest<FavMovie>(entityName: "FavMovie")
    }
    
    @NSManaged public var movieId: Int32
    @NSManaged public var moviePosterPath: String
    @NSManaged public var name: String

}
