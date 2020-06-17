//
//  CourseList.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 6/3/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(self.activeView.height / 500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30.0) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(show: self.$courses[index].show,
                                       course: self.courses[index],
                                       active: self.$active,
                                       index: index,
                                       activeIndex: self.$activeIndex,
                                       activeView: self.$activeView)
                                .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0) // offset modifier for second, takes to top
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                            
                        }
                        .frame(height: 280)
                            .frame(maxWidth:  self.courses[index].show ? .infinity : screen.width - 60)
                            .zIndex(self.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show : Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex : Int
    @Binding var activeView : CGSize
    
    var body: some View {
        ZStack (alignment: .top){
            
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Take your SwiftUI app to the App Store advanced techniques like API data, packaging and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("As we want to use the Book models in a ListView, they need to implement Identifiable, i.e. they need to have an id attribute. If you've worked with Firestore before, you know that each Firestore document has a unique document ID, so we can use that and map it to the id attribute. To make this easier, FirebaseFirestoreSwift provides a property wrapper, @DocumentID, which tells the Firestore SDK to perform this mapping for us. \n \n If the attribute names on your Firestore documents match with the property names of your model structs, you’re done now. However, if the attribute names differ, as they do in our example, you need to provide instructions for the Encoder / Decoder to map them correctly. We can do so by providing a nested enumeration that conforms to the CodingKey protocol.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? screen.height : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subTitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30: 20)
            .padding(.top, show ? 30: 0)
            .frame(maxWidth: self.show ? .infinity: screen.width - 60, maxHeight: self.show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.2), radius: 20, x: 0, y: 20)
            .gesture(
                show ?
                    DragGesture()
                        .onChanged{ value in
                            guard value.translation.height > 0 else { return }
                            guard value.translation.height < 300 else { return }
                            self.activeView = value.translation
                    }
                    .onEnded{ value in
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                        }
                        self.activeView = .zero
                    }
                    : nil
            )
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    if self.show {
                        self.activeIndex = self.index
                    } else {
                        self.activeIndex = -1
                    }
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
                DragGesture()
                    .onChanged{ value in
                        guard value.translation.height > 0 else { return }
                        guard value.translation.height < 300 else { return }
                        self.activeView = value.translation
                }
                .onEnded{ value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                    }
                    self.activeView = .zero
                }
                : nil
        )
            .edgesIgnoringSafeArea(.all)
    }
}

struct Course : Identifiable {
    var id = UUID()
    var title: String
    var subTitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prototype Designs in Swift UI", subTitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subTitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subTitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
