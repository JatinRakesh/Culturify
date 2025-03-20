//
//  File.swift
//  Culturify
//
//  Created by Jatin Rakesh on 19/3/25.
//

import Foundation
import SwiftUI

struct Welcome:View{
    @State private var circleSize: CGFloat = 300
    @State private var progress: CGFloat = 0.0
    @State private var isHolding = false
    @State private var navigateToContentView = false
    var body: some View{
        
        NavigationView{
        VStack {
          
            ZStack {
                Color(hex:"f5efe4")
                    .edgesIgnoringSafeArea(.all)

                Circle()
                    .fill(Color(hex: "faeacf"))
                                   .frame(width: circleSize)
                                   .padding()
                       
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color(hex: "eda51f").opacity(0.09), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: circleSize, height: circleSize)
                    .shadow(radius: 10)
                            
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "facc78"), Color(hex: "#8c6216")]),
                            startPoint: .bottom,
                            endPoint: .top
                        ),
                        style: StrokeStyle(lineWidth: 15, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Start filling from the top
                    .frame(width: circleSize, height: circleSize)
                    .animation(.linear(duration: 2), value: progress)
                               
                VStack {
                    Text("Welcome To Culturify!")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .foregroundStyle(.black)
                    Text("Discover the vast cultures that enrich")
                        .padding()
                        .foregroundStyle(.black)
                        .bold()
                        .font(.system(size: 14))
                    Text("Singaporeans as we head for SG60")
                        .padding(.vertical, -20)
                        .foregroundStyle(.black)
                        .bold()
                        .font(.system(size: 14))
                }
                Text("//Long press anywhere to continue")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding()
                    .offset(y:250)
                   
            }
            .navigationBarBackButtonHidden(true)
            .onLongPressGesture(minimumDuration: 1.5, pressing: { isPressing in
                if isPressing {
                    isHolding = true
                    withAnimation(.linear(duration: 2)) {
                        progress = 1.0
                    }
                } else {
                    isHolding = false
                    progress = 0.0
                }
            }) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigateToContentView = true
                }
            }
                
            }
            .background(
        NavigationLink("melw", destination: ContentView(), isActive: $navigateToContentView)
                .opacity(0)
                        )
          
               
            
        }
      
    }
}

#Preview{
    Welcome()
}
