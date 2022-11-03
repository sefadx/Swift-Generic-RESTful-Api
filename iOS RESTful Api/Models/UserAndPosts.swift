//
//  UserAndPosts.swift
//  iOS RESTful Api
//
//  Created by Sefa DİNÇER on 3.11.2022.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var countOfPosts: Int{
        posts.count
    }
}
