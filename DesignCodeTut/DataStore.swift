//
//  DataStore.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 6/17/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
