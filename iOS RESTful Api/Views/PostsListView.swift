//
//  PostsListView.swift
//  iOS RESTful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import SwiftUI

struct PostsListView: View {
    
    @StateObject var vm = PostsListViewModel()
    var userId: Int?
    
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .overlay(content: {
            if vm.isLoading{
                ProgressView()
            }
        })
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .task{
            vm.userId = userId
            await vm.fetchPosts()
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView(userId: 1)
    }
}
