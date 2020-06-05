//
//  TabBar.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 5/6/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
        
            ContentView().tabItem{
                Image(systemName: "rectangle.stack.fill")
                Text("Course List")
            }
            
            UpdateList().tabItem{
                Image(systemName: "bell")
                Text("Updates")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
//        Group {
//            Home().previewDevice("iPhone 8")
//            Home().previewDevice("iPhone 11")
//        }
    }
}
