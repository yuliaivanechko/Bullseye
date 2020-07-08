//
//  ContentView.swift
//  Bullseye
//
//  Created by Yuliia Ivanechko on 02.06.2020.
//  Copyright © 2020 Yuliia Ivanechko. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnighBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102/255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.yellow)
            .modifier(Shadow())
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }

    var body: some View {
        VStack {
           Spacer()
            // target row
            HStack {
                Text("Put the bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            
            // slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()

            // button row
            
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
                
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle()), message: Text(
                    "The slider's value is \(sliderValueRounded()).\n" +
                    "You scored \(pointsForRound()) points this round."
                    ), dismissButton: .default(Text("Awesome!")) {
                        self.score = self.score + self.pointsForRound()
                        self.target = Int.random(in: 1...100)
                        self.round = self.round + 1
                })
            }
            .background(Image("Button")).modifier(Shadow())

            Spacer()
            
            // score row
            
            HStack {

                Button(action: {
                    self.reset()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                    .padding(.horizontal)
                }
                    
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                
                Text("Score: ").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round: ").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                    .padding(.horizontal, 30)
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnighBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func amountOff() -> Int {
        abs(target - sliderValueRounded())
    }
    
    func sliderValueRounded() -> Int {
        Int(sliderValue.rounded())
    }
    
    func pointsForRound() -> Int {
        if 100 - amountOff() == 100 {
            return 200 - amountOff()
        } else if 100 - amountOff() == 99 {
            return 150 - amountOff()
        } else {
            return 100 - amountOff()
        }
    }
    
    func reset() {
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        var title: String
        if difference == 0 {
            title = "Perfect"
        } else if difference < 5 {
            title = "You almost have it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
