//
//  PasswordStrengthView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 12/12/23.
//

import SwiftUI

struct PasswordStrengthView: View {
    @Binding var description: String
    @State var offset = CGFloat()
    let ratio: CGFloat = 250
    let entropy: Double
    let gradient = Gradient(stops: [
        .init(color: .red, location: 0.07),
        .init(color: .orange, location: 0.15),
        .init(color: .yellow, location: 0.28),
        .init(color: .green, location: 0.36),
        .init(color: .blue, location: 1)
    ])

    var body: some View {
        VStack {
            VStack(alignment: .center) {

                Spacer().frame(height: 15)

                HStack {

                    Spacer()

                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .frame(width: 190 * UIScreen.main.bounds.width / ratio, height: 17)
                        .overlay(
                            VStack(alignment: .center) {
                                Rectangle()
                                    .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                                    .frame(width: 190 * UIScreen.main.bounds.width / ratio, height: 80)
                            }
                                .mask(VStack(alignment: .center) {
                                    Image(systemName: K.Image.triangleFill)
                                        .font(.system(size: 16))
                                }
                                    .offset(x: calculateOffset(entropy: entropy), y: 20)
                                    .foregroundColor(.blue)
                                    .shadow(radius: 1)
                                    .animation(.easeIn(duration: 0.55), value: entropy != 0)
                                    .transition(.opacity)))

                    Spacer()
                }
            }

            VStack {
                HStack {
                    Text(description)
                        .padding()
                }
            }
            .padding()

        }
    }
}

extension PasswordStrengthView {
    func calculateOffset(entropy: Double) -> CGFloat {
        switch entropy {
        case 0...42:
            return ((-190 * UIScreen.main.bounds.width / ratio) / 2) + 5 * (UIScreen.main.bounds.width) / ratio
        case 187...189:
            return ((-190 * UIScreen.main.bounds.width / ratio) / 2) + 186 * UIScreen.main.bounds.width / ratio
        default:
            return ((-190 * UIScreen.main.bounds.width / ratio) / 2) + (entropy - 10) * UIScreen.main.bounds.width / ratio
        }
    }
}

#Preview {
    PasswordStrengthView(description: .constant("Password Strength"), entropy: 190.0)
}
