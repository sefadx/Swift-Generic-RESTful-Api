//
//  Post.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 31.10.2022.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/posts
// Single User's Posts: https://jsonplaceholder.typicode.com/posts?userId=1

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
