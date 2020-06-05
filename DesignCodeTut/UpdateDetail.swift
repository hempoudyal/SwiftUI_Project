//
//  UpdateDetail.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 5/5/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update = updateData[0]
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .offset()
                    .lineLimit(4)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
                
                Spacer()
            }
            .navigationBarTitle(update.title)
        }
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
