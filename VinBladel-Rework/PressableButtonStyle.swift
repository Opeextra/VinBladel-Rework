import SwiftUI

public struct PressableButtonStyle: ButtonStyle {
    public var pressOffset: CGFloat
    public var animationDuration: Double

    public init(pressOffset: CGFloat = 8, animationDuration: Double = 0.18) {
        self.pressOffset = pressOffset
        self.animationDuration = animationDuration
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .offset(x: configuration.isPressed ? pressOffset : 0, y: 0)
            .animation(.easeOut(duration: animationDuration), value: configuration.isPressed)
    }
}
