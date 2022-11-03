//
//  UserListViewModel.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIServices(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIServices(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading.toggle()
        defer{
            isLoading.toggle()
        }
        do {
            async let users: [User] = try await apiService.getJSON()
            async let posts: [Post] = try await apiService2.getJSON()
            let (fetchedUsers,fetchedPosts) = await (try users, try posts)
            for user in fetchedUsers{
                let userPosts = fetchedPosts.filter {$0.userId == user.id}
                usersAndPosts.append(UserAndPosts(user: user, posts: userPosts))
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this reproduce"
        }
        
    }
}

extension UserListViewModel  {
    convenience init(forPreview: Bool = false){
        self.init()
        if forPreview{
            self.usersAndPosts = UserAndPosts.fakeUsersAndPosts
        }
    }
}
