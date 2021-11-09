//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Zharikova on 11/7/21.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image:String
    var title:String
    var description:String
    var count:String
    var time:String
    
    var body: some View {
       
        ZStack{
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
                
            
            HStack{
                Image(image)
                .resizable()
                .frame(width: 116, height: 116)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                VStack (alignment: .leading,spacing:10) {
                    Text(title)
                        .bold()
                    
                    Text(description)
                        .padding(.bottom,20)
                        .font(.caption)
                    
                    HStack{
                        
                        //number of lessons
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 11, height: 11)
                        Text(count)
                            .font(Font.system(size: 10))
                        Spacer()
                        //time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 11, height: 11)
                  
                        Text(time)
                            .font(Font.system(size: 10))
                    }
                    .padding(.trailing,20)
                }
                .padding(.leading, 20)
            }
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "description is very very very very very long", count: "10 Lessons", time: "2 hours")
    }
}
