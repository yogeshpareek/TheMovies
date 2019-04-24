//
//  MovieFavManager.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 22/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit
import CoreData

class MovieFavManager {
    
    private let persistentContainer: NSPersistentContainer!
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    private var allFav: [FavMovie] = []
    
    static var shared: MovieFavManager = {
        return MovieFavManager()
    }()
    
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        configure()
    }
    
    private convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    private func configure() {
        allFav.append(contentsOf: fetchAll())
    }
    
    @discardableResult
    func insertFavMovie(movie: Movie) -> FavMovie? {
        
        guard let favMovie = NSEntityDescription.insertNewObject(forEntityName: "FavMovie", into: backgroundContext) as? FavMovie else { return nil }
        favMovie.name = movie.title
        favMovie.moviePosterPath = movie.fullPosterPath
        favMovie.movieId = Int32(movie.id)
        
        allFav.append(favMovie)
        save()
        return favMovie
    }
    
    func isFav(movie: Movie) -> FavMovie? {
        return allFav.filter { $0.movieId == Int32(movie.id) }.first
    }
    
    func toggleFav(movie: Movie) {
        if let fav = isFav(movie: movie) {
            remove(objectID: fav.objectID)
        } else {
            insertFavMovie(movie: movie)
        }
    }
    
    public func fetchAll() -> [FavMovie] {
        let request: NSFetchRequest<FavMovie> = FavMovie.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [FavMovie]()
    }
    
    func remove(objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        save()
    }
    
    func remove(favMovie: FavMovie ) {
        backgroundContext.delete(favMovie)
        save()
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
        
    }

    
    
}
