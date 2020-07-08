//
//  AboutView.swift
//  Bullseye
//
//  Created by Yuliia Ivanechko on 10.06.2020.
//  Copyright © 2020 Yuliia Ivanechko. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let lightOrange = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    let midnighBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102/255.0)
    
    struct HeaderStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeaderStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are the more points you will score.").modifier(TextStyle()).lineLimit(nil)
                Text("Enjoy!").modifier(TextStyle())
            }
            .background(lightOrange)
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
        .accentColor(midnighBlue)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 667, height: 375))
    }
}
