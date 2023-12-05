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
            ScrollView {
                Text(K.Strings.passwordHowManyCharacters)
                    .foregroundStyle(.purple)
                    .font(.title2)

                Slider(value: $charCount, in: 1...20, step: 1) {
                } minimumValueLabel: {
                    Text("1")
                        .font(.title2)
                } maximumValueLabel: {
                    Text("20")
                        .font(.title2)
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .padding()

                Text("\(Int(charCount))")
                    .foregroundColor(isEditing ? Color(K.Strings.myGreen) : .purple)
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
                    print("tapped generate password")
                } label: {
                    Image(systemName: K.Strings.wandAndStars)
                        .imageScale(.large)
                    Text(K.Strings.generatePassword)
                        .font(.title3)
                }
                .buttonStyle(.bordered).controlSize(.large)
                .padding()

                Text("Generated Password goes here")
                    .font(.title3)
                    .padding()

                Button {
                    print("tapped copy")
                } label: {
                    Image(systemName: K.Strings.docOndoc)
                        .imageScale(.large)
                    Text("Copy")
                        .font(.title3)
                }
                .buttonStyle(.borderless).controlSize(.small)
                .padding()
            }
            .navigationTitle(K.Strings.passwordGeneratorNavTitle)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    PasswordGeneratorView()
}
