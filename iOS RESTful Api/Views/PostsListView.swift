//
//  PostsListView.swift
//  iOS RESTful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import SwiftUI

struct PostsListView: View {
    var posts: [Post]
    var body: some View {
        List{
            ForEach(posts){ post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsListView(posts: Post.fakeUserPosts)
    }
}

