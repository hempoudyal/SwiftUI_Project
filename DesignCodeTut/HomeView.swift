//
//  HomeView.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 4/25/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                       //.bold().modifier(CustomFontModifier(size: 28))
                    Spacer()
                    
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: {self.showUpdate.toggle()}) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color("primary").opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color("primary").opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                 
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 40) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX  - 30) / -20), axis: (x: 0, y: 10.0, z: 0)) // minY for vertical scroll, for parallax animation
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                
                HStack() {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30.0)
                .offset(y: -60)
                
                SectionView(section: sectionData[2], width: screen.width - 80, height: 275)
                .offset(y: -60)
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold ))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                Image(section.logo)
            }
            Text(section.text .uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .frame(width: width, height: height)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable{
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [Section(title: "Prototype designs in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
                   Section(title: "Apps built in SwiftUI", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))),
                   Section(title: "Advanced Courses in SwiftUI", text: "16 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))]

struct WatchRingsView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 20.0) {
            HStack(alignment: .top, spacing: 20.0) {
                RingView(color1: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), color2: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), width: 44, height: 44, percent: 80, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 5.0) {
                    Text("6 minutes left")
                        .bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today")
                        .modifier(FontModifier(style: .caption))
                        .foregroundColor(.gray)
                }
            }
            .padding(8)
            .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            RingView(color1: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), color2: Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)), width: 44, height: 44, percent: 46, show: .constant(true))
                .padding(10)
                .background(Color.white)
                .modifier(CornerModifier(radius: 20))
                .modifier(ShadowModifier())
            
            RingView(color1: Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), color2: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), width: 44, height: 44, percent: 22, show: .constant(true))
                .padding(10)
                .background(Color.white)
                .modifier(CornerModifier(radius: 20))
                .modifier(ShadowModifier())
        }
        .padding(.bottom, 30)
        .padding(.horizontal, 30)
    }
}
