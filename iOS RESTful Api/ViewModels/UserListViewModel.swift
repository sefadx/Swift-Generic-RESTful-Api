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
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIServices(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        defer{
            isLoading.toggle()
        }
        do {
            users = try await apiService.getJSON()
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
            self.users = User.fakeUsers
        }
    }
}
