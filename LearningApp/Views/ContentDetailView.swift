//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Zharikova on 11/8/21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl +
                        (lesson?.video ?? ""))
        VStack {
        if url != nil {
        VideoPlayer(player: AVPlayer(url: url!))
            .cornerRadius(10)
        }
            //Description
            CodeTextView()
            //show Next lesson button oly if there is next lesson
        if model.hasNextLesson() {
            
        Button(action: {model.nextLesson()}, label: {
              
                ZStack {
                    RectangleCard(color:Color.green)
                    .frame(height:48)
                Text("Next Lesson \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                    .foregroundColor(.white)
                    .bold()
                }
                }
                )
            }
        else {
            //show the complete button instead
            Button(action:
                    //take user back to the home view
                    {model.currentContentSelected = nil}, label: {
                  
                    ZStack {
                    RectangleCard(color:Color.green)
                        .frame(height:48)
                    Text("Complete")
                        .foregroundColor(.white)
                        .bold()
                    }
                    }
                    )
        }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
