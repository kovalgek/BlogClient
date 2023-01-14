//
//  PostViewModel.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 14/01/2023.
//

import Foundation

protocol PostViewModelProtocol {
    func loadPost()
    var post: Observable<Post> { get }
}

class PostViewModel: PostViewModelProtocol {
    
    private let service: Postse
    
    func loadPost() {
        
    }
    
    var post: Observable<Post> = Observable(nil)
}
