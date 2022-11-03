//
//  PostsListViewModel.swift
//  iOS RESTful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    @MainActor
    func fetchPosts() async{
        if let userId = userId {
            let apiService = APIServices(urlString: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
            isLoading.toggle()
            defer{
                isLoading.toggle()
            }
            do {
                posts = try await apiService.getJSON()
            } catch {
                showAlert = true
                errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this reproduce"
            }
            
        }
    }
}

extension PostsListViewModel  {
    convenience init(forPreview: Bool = false){
        self.init()
        if forPreview{
            self.posts = Post.fakePosts
        }
    }
}
