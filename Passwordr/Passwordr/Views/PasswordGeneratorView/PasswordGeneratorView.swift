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
            ZStack {
                Form {
                    Section {
                        Slider(value: $charCount, in: 1...20, step: 1) {
                        } minimumValueLabel: {
                            Text("1")
                        } maximumValueLabel: {
                            Text("20")
                        } onEditingChanged: { editing in
                            isEditing = editing
                        }
                    } header: {
                        Text(K.Strings.passwordHowManyCharacters) +
                        Text(" \(Int(charCount))").foregroundStyle(.myGray).font(.body).bold()
                    }

                    Section {
                        Toggle(isOn: $isSymbolsOn) {
                            Text(K.Strings.passwordIncludeSymbol)
                                .foregroundStyle(Color(.myBlue))
                        }.toggleStyle(.switch).tint(Color(.myBlue))

                        Toggle(isOn: $isNumbersOn) {
                            Text(K.Strings.passwordIncludeNumber)
                                .foregroundStyle(Color(.myOrange))
                        }.toggleStyle(.switch).tint(Color(.myOrange))

                        Toggle(isOn: $hasUpperCase) {
                            Text(K.Strings.passwordIncludeUpperCase)
                                .foregroundStyle(Color(.myRed))
                        }.toggleStyle(.switch).tint(Color(.myRed))

                        Toggle(isOn: $isEmptySpaceOn) {
                            Text(K.Strings.passwordIncludeEmptySpace)
                                .foregroundStyle(Color(.myPurple))
                        }.toggleStyle(.switch).tint(Color(.myPurple))
                    }

                    Button {
                        characters = viewModel.generatePassword(lenght: Int(charCount), specialCharacters: isSymbolsOn, uppercase: hasUpperCase, numbers: isNumbersOn, emptySpace: isEmptySpaceOn)
                        generatedPassword = characters.joined()
                    } label: {
                            Image(systemName: K.Image.wandAndStars)
                                .imageScale(.large)
                            Text(K.Strings.generatePassword)
                    }
                    .buttonStyle(.borderless)
                    .frame(maxWidth: .infinity, maxHeight: 0, alignment: .center)
                    .padding()

                    Section {
                        HStack(spacing: 0.5) {
                            if generatedPassword.isEmpty {
                                Text(K.Strings.password)
                                    .foregroundStyle(Color(.myGray))
                            } else {
                                ForEach(characters, id: \.self) { character in
                                    Text(character)
                                        .foregroundColor(viewModel.specialCharactersArray.contains(character) ? Color(.myBlue) : viewModel.numbersArray.contains(character) ? Color(.myOrange) : viewModel.alphabet.contains(character) ? Color(.myGray) : Color(.myRed))
                                }
                            }

                            Spacer()

                            Button {
                                print("tapped copy")
                            } label: {
                                Image(systemName: K.Image.docOndoc)
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderless).controlSize(.large)
                        }
                        .animation(.easeOut, value: 0.2)
                    }
                }
            }
            .navigationTitle(K.Strings.passwordGeneratorNavTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PasswordGeneratorView()
}
