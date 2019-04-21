//
//  MovieCrew.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieCrew: Decodable {
    
    var creditId: String = ""
    var department: String = ""
    var gender: Int = 1
    var id: Int = -1
    var job: String = ""
    var name: String = ""
    var profilePath: String = ""
    
    enum CodingKeys: String, CodingKey {
        case creditId = "credit_id"
        case department
        case gender
        case id
        case job
        case name
        case profilePath = "profile_path"
    }
    
    var fullProfilePath: String {
        return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(self.profilePath)"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        creditId = try values.decode(String.self, forKey: .creditId)
        department = try values.decode(String.self, forKey: .department)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender) ?? 0
        id = try values.decode(Int.self, forKey: .id)
        job = try values.decode(String.self, forKey: .job)
        name = try values.decode(String.self, forKey: .name)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
    }
    
}
