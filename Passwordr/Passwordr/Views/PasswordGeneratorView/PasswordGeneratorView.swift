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
    @State private var isEmptySpaceOn = false
    @State private var hasUpperCase = false
    @State private var generatePassword = false
    @State private var characters = [String]()
    @State private var generatedPassword = ""
    @ObservedObject var viewModel = PasswordGeneratorViewModel()

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

                Text("\(Int(charCount))")
                    .foregroundColor(isEditing ? Color(K.Strings.myGreen) : .purple)
                    .font(.title2)
                    .padding(.top, -16)

                VStack {
                    Toggle(isOn: $isSymbolsOn) {
                        Text(K.Strings.passwordIncludeSymbol)
                            .foregroundStyle(Color(K.Strings.myTeal))
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $isNumbersOn) {
                        Text(K.Strings.passwordIncludeNumber)
                            .foregroundStyle(Color(K.Strings.myYellow))
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $isEmptySpaceOn) {
                        Text(K.Strings.passwordIncludeEmptySpace)
                            .font(.title2)
                    }
                    .padding(.bottom, 20)

                    Toggle(isOn: $hasUpperCase) {
                        Text(K.Strings.passwordIncludeUpperCase)
                            .foregroundStyle(Color(K.Strings.myRed))
                            .font(.title2)
                    }
                }
                .padding()
                .padding(.bottom, 30)

                Button {
                    characters = viewModel.generatePassword(lenght: Int(charCount), specialCharacters: isSymbolsOn, uppercase: hasUpperCase, numbers: isNumbersOn, emptySpace: isEmptySpaceOn)
                    generatedPassword = characters.joined()
                } label: {
                    Image(systemName: K.Strings.wandAndStars)
                        .imageScale(.large)
                    Text(K.Strings.generatePassword)
                        .font(.title3)
                }
                .buttonStyle(.plain).controlSize(.regular)
                .foregroundStyle(Color(K.Strings.myGreen))
                .clipShape(.buttonBorder)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(K.Strings.myGreen), lineWidth: 1))

                HStack(spacing: 0.5) {
                    if generatedPassword.isEmpty {
                        Text(K.Strings.password)
                            .foregroundStyle(Color(K.Strings.myGray))
                            .padding(.top, 20)
                    } else {
                        ForEach(characters, id: \.self) { character in
                            Text(character)
                                .foregroundColor(viewModel.specialCharactersArray.contains(character) ? Color(K.Strings.myTeal) : viewModel.numbersArray.contains(character) ? Color(K.Strings.myYellow) : viewModel.alphabet.contains(character) ? Color(K.Strings.myWhite) : Color(K.Strings.myRed))
                                .padding(.top, 20)
                        }
                    }
                }
                .font(.title3)
                .animation(.easeOut, value: 0.2)

                Button {
                    print("tapped copy")

                } label: {
                    Image(systemName: K.Strings.docOndoc)
                        .imageScale(.large)
                    Text(K.Strings.copy)
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
