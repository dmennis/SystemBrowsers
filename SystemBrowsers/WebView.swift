//
//  WKWebView.swift
//  SystemBrowsers
//
//  Created by Dennis Hills on 9/8/22.
//
import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    let url: URL
    
    // Return an instance of WKWebView
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
