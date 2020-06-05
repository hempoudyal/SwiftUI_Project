//
//  CourseList.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 6/3/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    @State var show = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("SwiftUI Advanced")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("20 Sections")
                        .foregroundColor(Color.white.opacity(0.7))
                }
                Image(uiImage: #imageLiteral(resourceName: "Logo1"))
            }
            Image(uiImage: #imageLiteral(resourceName: "Card4"))
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(show ? 30: 20)
        .padding(.top, show ? 30: 0)
        .frame(maxWidth: self.show ? .infinity: screen.width - 60, maxHeight: self.show ? .infinity : 280)
        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .cornerRadius(20)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.show.toggle()
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}
