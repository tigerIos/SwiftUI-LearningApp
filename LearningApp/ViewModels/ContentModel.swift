//
//  ContentModel.swift
//  LearningApp
//
//  Created by Zharikova on 11/5/21.
//

import Foundation


class ContentModel:ObservableObject {
    
    //List of modules
    @Published var modules=[Module]()
    
    //Current module
    @Published var currentModule :Module?
    var currentModuleIndex = 0
    
    //Current lesson
    @Published var currentLesson:Lesson?
    var currentLessonIndex = 0
    
    //Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    //Current selected content and test
    @Published var currentContentSelected : Int?
    
    
    var styleData:Data?
    
    init() {
        
        getLocalData()
    }
    
    //MARK: - data methods
    
    func getLocalData(){
        
       // 1. Get URL to the JSON file
        let jsonUrl=Bundle.main.url(forResource: "data", withExtension: "json")
        do {
        //2.Read the file into a data object
        let jsonData = try Data(contentsOf: jsonUrl!)
        let jsonDecoder = JSONDecoder()
            
          
           let modules = try jsonDecoder.decode([Module].self, from: jsonData)
                //Assign parsed modeules to modules property
                self.modules = modules
         
        }
        catch {
            print ("Couldn't parse json data")
        }
        
        //Parse the style data
        let styleUrl=Bundle.main.url(forResource: "style", withExtension: "html")
        do {
        //Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print("Couldn't parse style data")
        }
    }
    
    //MARK: - module navigation methods
    
    func beginModule (_ moduleId:Int) {
        
        //Find the index for the module id
        for index in 0..<modules.count {
            
            //find the matching module
            if  modules[index].id == moduleId {
                
                currentModuleIndex = index
                
                break
            }
            
        }
        //Set the current module
        
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        //Check that the lesson index is within range of moduel lessons
        
        if lessonIndex < currentModule!.content.lessons.count {
            
            currentLessonIndex = lessonIndex
        }
        else {
            
            currentLessonIndex = 0
        }
        //Set the lesson index
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        lessonDescription = addStyling(currentLesson!.explanation)
        
        
    }
    
    // Advance to next lesson
    
    func nextLesson() {
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            
            currentLesson = nil
            currentLessonIndex = 0
            
        }
    }
    
    func hasNextLesson()-> Bool {
        
       return  (currentLessonIndex+1 < currentModule!.content.lessons.count)
        
    }
    
    //MARK: - Code Styling
    
    private func addStyling (_ htmlString:String)-> NSAttributedString {
        
       var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data
        if styleData != nil {
        data.append (styleData!)
        }
        
        //Add the html data
        data.append(Data(htmlString.utf8))
        
        //Convert to attributed string
      
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType :NSAttributedString.DocumentType.html], documentAttributes: nil)
        {resultString = attributedString}
       
        
        return resultString
    }
}
