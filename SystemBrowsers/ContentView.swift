//
//  ContentView.swift
//  SystemBrowsers
//
//  Created by Dennis Hills on 9/8/22.
//
//  To use a WKWebView (as a UIKit view) in SwiftUI, we need wrap the view with the UIViewRepresentable protocol. We do this by creating struct in SwiftUI that adopts the protocol to create and manage our WKWebView (as a UIView object). However, we are using the BetterSafariView library SPM for simplicity (less boilerplate stuff).

import SwiftUI
import BetterSafariView

struct ContentView: View {
    
    @State private var showingWKWebView = false
    @State private var showingSafariVC = false
    @State private var showingWebAuthenticationSession = false
    
    var body: some View {
        VStack {
            // WKWebView
            Button {
                showingWKWebView.toggle()
            } label: {
                Text("WKWebView")
            }
            .padding(25.0)
            .buttonStyle(YubicoGreenButton())
            .sheet(isPresented: $showingWKWebView) {
                WebView(url: URL(string: "https://client.badssl.com")!)
            }
            
            // WebAuthenticationSession
            Button(action: {
                showingWebAuthenticationSession.toggle()})
            {
                Text("WebAuthenticationSession")
            }
            //.padding(5.0)
            .buttonStyle(YubicoGreenButton())
            .webAuthenticationSession(isPresented: $showingWebAuthenticationSession) {
                WebAuthenticationSession(
                    url: URL(string: "https://client.badssl.com")!,
                            callbackURLScheme: "badssl"
                        ) { callbackURL, error in
                            print(callbackURL as Any, error as Any)
                        }
                        .prefersEphemeralWebBrowserSession(false)
            }
            
            // SFSafariViewController
            Button(
                action: {
                    showingSafariVC.toggle()
                }) {
                    Text("SFSafariViewController")
                }
            .padding(25.0)
            .buttonStyle(YubicoGreenButton())
            .safariView(isPresented: $showingSafariVC) {
                SafariView(
                    url: URL(string: "https://client.badssl.com/")!,
                    configuration: SafariView.Configuration(
                        entersReaderIfAvailable: false,
                        barCollapsingEnabled: true
                    )
                )
                .preferredBarAccentColor(.clear)
                .preferredControlAccentColor(.accentColor)
                .dismissButtonStyle(.done)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct YubicoGreenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .bold()
            .padding(25.0)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
