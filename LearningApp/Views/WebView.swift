//
//  WebView.swift
//  LearningApp
//
//  Created by Zharikova on 11/13/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url:URL
    
    func makeUIView(context: Context) -> some UIView {
        let webview = WKWebView()
        let request = URLRequest(url: url)
        
        webview.load(request)
        return webview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        return
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url:URL(string:"https://codewithchris.com")!)
            .edgesIgnoringSafeArea(.bottom)
    }
}
