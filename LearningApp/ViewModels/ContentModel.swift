//
//  ContentModel.swift
//  LearningApp
//
//  Created by Zharikova on 11/5/21.
//

import Foundation


class ContentModel:ObservableObject {
    
    @Published var modules=[Module]()
    var styleData:Data?
    
    init() {
        
        getLocalData()
    }
    
    
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
}
