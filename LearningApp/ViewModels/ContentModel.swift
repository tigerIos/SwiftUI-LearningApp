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
    
    //Current question
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    
    
    //Current lesson explanation
    @Published var CodeText = NSAttributedString()
    
    //Current selected content and test
    @Published var currentContentSelected : Int?
    @Published var currentTestSelected: Int?
    
    var styleData:Data?
    
    init() {
        
        //parse local included json data
        getLocalData()
        
        //download remote json file and parse data
   //     getRemoteData()
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
    
 //   func getRemoteData() {
        
//    }
    
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
        
        CodeText = addStyling(currentLesson!.explanation)
        
        
    }
    
    // Advance to next lesson
    
    func nextLesson() {
        currentLessonIndex += 1
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            CodeText = addStyling(currentLesson!.explanation)
        }
        else {
            
            currentLesson = nil
            currentLessonIndex = 0
            
        }
    }
    
    func hasNextLesson()-> Bool {
        
       return  (currentLessonIndex+1 < currentModule!.content.lessons.count)
        
    }
    
    func beginTest(_ moduleId:Int) {
        
        //set the current module
        beginModule(moduleId)
        
        //set the current question index
        currentQuestionIndex = 0
        
        //if there are questions, set teh current question to the 1st one
        if currentModule?.test.questions.count ?? 0 > 0 {
           currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            //Set the question ocntent as well
            CodeText = addStyling(currentQuestion!.content)
            
        }
        
    }
    
    func nextQuestion () {
        //Advance the question index
        currentQuestionIndex += 1
        
        //Check if its in the range of index
        if currentQuestionIndex<currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            CodeText = addStyling(currentQuestion!.content)
        }
        else {
            //Reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
     
        
        
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
