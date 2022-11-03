//
//  User.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 31.10.2022.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
