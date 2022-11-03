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
    
    func fetchPosts(){
        if let userId = userId {
            let apiService = APIServices(urlString: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)")
            isLoading.toggle()
            apiService.getJSON { (result: Result<[Post], APIError>) in
                defer{
                    self.isLoading.toggle()
                }
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this reproduce"
                    }
                }
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
