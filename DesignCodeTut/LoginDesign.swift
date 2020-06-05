//
//  LoginDesign.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 4/16/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct LoginDesign: View {
    @State var show = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Username")
                    .font(.title)
                Spacer()
                
                TextField("Username", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 200)
                
            }
            .padding(.horizontal)
            
            HStack {
                Text("Email")
                    .font(.title)
                Spacer()
                
                TextField("Email", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 200)
                
            }
            .padding(.horizontal)
            
            HStack {
                Text("Password")
                    .font(.title)
                Spacer()
                
                TextField("Password", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 200)
                
            }
            .padding(.horizontal)
            
        }
        
    }
}

struct LoginDesign_Previews: PreviewProvider {
    static var previews: some View {
        LoginDesign()
    }
}

