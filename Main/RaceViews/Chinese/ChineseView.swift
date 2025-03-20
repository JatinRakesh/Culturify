

import SwiftUI
import ARKit
import RealityKit

struct ChineseView: View {
    @State private var expandedIndex: Int? = nil
    let images = ["MoonCake", "LionDance", "RPM"]


    var body: some View {
        ZStack {
            Color(hex: "f5efe4").edgesIgnoringSafeArea(.all)

            if expandedIndex == nil {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "f5ddb0"))
                            .opacity(0.7)
                            .frame(width: 375, height: 470)
                            .offset(y: -140)
                        VStack {
                            Text("The Chinese Culture")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .offset(x: -15, y: -185)
                            Text("The Chinese culture, forming 75.9% of Singapore’s population, influences values, traditions, and daily life.")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .offset(x: 15, y: -145)
                                .frame(maxWidth: 300)
                                .multilineTextAlignment(.leading)
                            Text("The more prominent feature of the Chinese culture is the Chinese New Year!")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .offset(x: 5, y: -125)
                                .frame(maxWidth: 300)
                                .multilineTextAlignment(.leading)
                            Text("From angbaos to tasty mooncakes to spectacular dragon dance performances, the Chinese New Year certainly is spectacular!")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .offset(x: 15, y: -100)
                                .frame(maxWidth: 300)
                                .multilineTextAlignment(.leading)
                            Text("//Click the 3 buttons down below to see the 3 different aspects of Chinese New Year")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .offset(x: 15, y: -40)
                                .frame(maxWidth: 300)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }

                HStack(spacing: 10) {
                    ForEach(0..<3, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "f5ddb0"))
                            .frame(width: 120, height: 150)
                            .overlay(
                                VStack {
                                   
                                        Image(images[index])    .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100) .cornerRadius(15)
                                    
                                HStack {
                                    Spacer()
                                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .foregroundColor(.black)
                                            .padding(5)
                                    }
                                    Spacer()
                                }
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    expandedIndex = index
                                }
                            }
                    }
                }
                .offset(y: 230)
                .padding(.horizontal, 20)
            } else {
                ExpandedRectangleView(onCollapse: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandedIndex = nil
                    }
                }, expandedIndex: expandedIndex!)
                .edgesIgnoringSafeArea(.all)
                .transition(.scale)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
    
struct ExpandedRectangleView: View {
    let onCollapse: () -> Void
    let expandedIndex: Int
  
    var body: some View {
        ZStack {
            if expandedIndex == 0 {
                ARViewControllerWrapper()
                    .edgesIgnoringSafeArea(.all)
            } else if expandedIndex == 1 {
                LionDanceWrapper()
                    .edgesIgnoringSafeArea(.all)
            }
            else if expandedIndex == 2 {
                RPandMandarinWrapper()
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                HStack {
                    Button(action: onCollapse) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .padding(.leading, 20)
                            .padding(.top, 50)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    ChineseView()
}        
