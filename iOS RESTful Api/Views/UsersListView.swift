//
//  ContentView.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 31.10.2022.
//

import SwiftUI

struct UsersListView: View {
    
    #warning("remove the forPreview argument or set it to false before uploading to App Store")
    @StateObject var vm = UserListViewModel(forPreview: true)
    
    var body: some View {
        NavigationView{
            List{
                ForEach(vm.usersAndPosts){ userAndPost in
                    NavigationLink {
                        PostsListView(posts: userAndPost.posts)
                    } label: {
                        VStack(alignment: .leading){
                            HStack{
                                Text(userAndPost.user.name)
                                    .font(.headline)
                                Spacer()
                                Text("\(userAndPost.countOfPosts)")
                            }
                            Text(userAndPost.user.email)
                        }
                    }

                    
                    
                }
            }
            .overlay(content: {
                if vm.isLoading{
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK"){}
            }, message: {
                if let errorMessage = vm.errorMessage{
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task{
                await vm.fetchUsers()
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
