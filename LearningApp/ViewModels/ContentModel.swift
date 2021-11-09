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
    
    
}
