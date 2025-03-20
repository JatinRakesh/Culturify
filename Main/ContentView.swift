
import SwiftUI

struct ContentView: View {
    @State private var wiggles: Bool = false
    @State  var cultures: [(name: String, color: String, destination: AnyView, wiggles: Bool, lock: Bool)] = [
        ("Chinese", "fae38e", AnyView(ChineseView()), true, false),
        ("Malay", "bd9364", AnyView(MalayView()), false, true),
        ("Indian", "7a5832", AnyView(IndianView()), false, true),
        ("Others", "fadeaf", AnyView(OthersView()), false, true)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "f5efe4")
                    .edgesIgnoringSafeArea(.all)

                
                Text("//Click on the button that is wiggling")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .padding()
                    .offset(y: 280)
                
                VStack(spacing: 10) {
                    ForEach(0..<2, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<2, id: \.self) { column in
                                let index = row * 2 + column
                                let culture = cultures[index]
                                
                                CultureButton(
                                    name: culture.name,
                                    color: culture.color,
                                    destination: culture.destination,
                                    wiggles: culture.wiggles,
                                    lock: culture.lock
                                )
                            }
                        }
                    }
                    .padding()
                    .offset(y: -70)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct CultureButton<Destination: View>: View {
    let name: String
    let color: String
    let destination: Destination
    let wiggles: Bool
    let lock: Bool
    
    @State private var isWiggling = false

    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                NiceRect()
                    .scaledToFill()
                    .scaledToFit()
                    .padding()
                    .foregroundStyle(Color(hex: color))
                    .frame(width: 200, height: 220)
                    .opacity(lock ? 0.55 : 1)

                Text(name)
                    .foregroundColor(.white)
                    .grayscale(lock ? 1.0 : 0.0)
                    .font(.title)
                    .bold()
                
                if lock {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                        .offset(x: 0, y: 0)
                }
            }
            .scaleEffect(isWiggling ? 1.05 : 1.0)
            .offset(y: isWiggling ? -1 : 0)
            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isWiggling)
         
            .onAppear {
                if wiggles {
                    isWiggling = true
                }
            }
            
        }
        .disabled(lock)
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
