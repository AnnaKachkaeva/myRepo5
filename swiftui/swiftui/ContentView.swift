import SwiftUI

struct ContentView: View {
    @State var location: CGPoint = CGPoint(x: 300, y: 300)
    let allColors = [Color.white, .pink, .yellow, .black]

    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
            }
    }

    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                ForEach(allColors, id: \.self) { color in

                    Rectangle()
                        .fill(
                            color
                        )
                }.ignoresSafeArea()

            }

            let rect = RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 100)
                .position(location)
                .gesture(
                    simpleDrag
                )

                rect.foregroundColor(.white)
                .overlay(rect.blendMode(.hue))
                .overlay(rect.foregroundColor(.white).blendMode(.overlay))
                .overlay(rect.foregroundColor(.black).blendMode(.overlay))
                .blendMode(.difference)
        }
    }


}

extension Color {
    func luminance() -> Double {
        // 1. Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)

        // 2. Extract RGB values
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)

        // 3. Compute luminance.
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }

    func isLight() -> Bool {
        return luminance() > 0.5
    }

    func adaptedColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}
