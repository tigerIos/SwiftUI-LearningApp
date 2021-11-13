//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Zharikova on 11/13/21.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
   
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}


