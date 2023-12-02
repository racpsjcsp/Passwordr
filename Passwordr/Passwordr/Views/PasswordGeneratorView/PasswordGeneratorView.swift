//
//  PasswordGeneratorView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 02/12/23.
//

import SwiftUI

struct PasswordGeneratorView: View {
    @State private var charCount = 20.0
    @State private var isEditing = false
    @State private var isSymbolsOn = false
    @State private var isNumbersOn = false
    @State private var hasEmptySpace = false
    @State private var hasUpperCase = false
    @State private var generatePassword = false

    var body: some View {
        NavigationStack {
            VStack {
                Text(K.Strings.passwordHowManyCharacters)
                    .foregroundStyle(.purple)
                    .font(.title2)

                Slider(value: $charCount, in: 1...20, step: 1) {
                    Text("Quantity")

                } minimumValueLabel: {
                    Text("1")
                        .font(.title2)
                } maximumValueLabel: {
                    Text("20")
                        .font(.title2)
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .padding([.leading, .trailing], 20)

                Text("\(Int(charCount))")
                    .foregroundColor(isEditing ? .red : Color(K.Strings.myGreen))
                    .font(.title2)

                VStack {
                    Toggle(isOn: $isSymbolsOn) {
                        Text(K.Strings.passwordIncludeSymbol)
                            .foregroundStyle(.purple)
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $isNumbersOn) {
                        Text(K.Strings.passwordIncludeNumber)
                            .foregroundStyle(.purple)
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $hasEmptySpace) {
                        Text(K.Strings.passwordIncludeEmptySpace)
                            .foregroundStyle(.purple)
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $hasUpperCase) {
                        Text(K.Strings.passwordIncludeUpperCase)
                            .foregroundStyle(.purple)
                            .font(.title2)
                    }
                }
                .padding()

                Button {
                    print("tapped")
                } label: {
                    Image(systemName: K.Strings.wandAndStars)
                        .imageScale(.large)
                    Text(K.Strings.generatePassword)
                        .font(.title3)
                }
                .buttonStyle(.bordered).controlSize(.large)
                .padding(.top, 60)
            }
            .navigationTitle(K.Strings.passwordGeneratorNavTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PasswordGeneratorView()
}
