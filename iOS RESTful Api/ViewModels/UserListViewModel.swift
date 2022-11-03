//
//  UserListViewModel.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    func fetchUsers() {
        let apiService = APIServices(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        apiService.getJSON { (result: Result<[User], APIError>) in
            defer{
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
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

extension UserListViewModel  {
    convenience init(forPreview: Bool = false){
        self.init()
        if forPreview{
            self.users = User.fakeUsers
        }
    }
}
