//
//  FakeData.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import Foundation

extension User {
    static var fakeUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    static var fakeUser: User {
        Self.fakeUsers[0]
    }
}

extension Post {
    static var fakePosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    static var fakePost: Post {
        Self.fakePosts[0]
    }
    static var fakeUserPosts: [Post] {
        self.fakePosts.filter { post in
            post.id == 1
        }
    }
}
