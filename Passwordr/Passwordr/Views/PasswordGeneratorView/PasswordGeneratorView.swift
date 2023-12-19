//
//  PasswordGeneratorView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 02/12/23.
//

import SwiftUI

struct PasswordGeneratorView: View {
    @State private var charCount = 30.0
    @State private var isEditing = false
    @State private var isSymbolsOn = false
    @State private var isNumbersOn = false
    @State private var isEmptySpaceOn = false
    @State private var hasUpperCase = false
    @State private var generatePassword = false
    @State private var characters = [String]()
    @State private var generatedPassword = ""
    @State private var generatedPasswordEntropy = 0.0
    @State private var strengthDescription = ""
    private var clipboardString: String = ""
    @ObservedObject var viewModel = PasswordGeneratorViewModel()
    @State private var copied = false {
        didSet {
            if copied {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        copied = false
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Form {
                        Section {
                            Slider(value: $charCount, in: 1...30, step: 1) {
                            } minimumValueLabel: {
                                Text("1")
                            } maximumValueLabel: {
                                Text("30")
                            } onEditingChanged: { editing in
                                isEditing = editing
                                generatedPassword = ""
                                generatedPasswordEntropy = 0.0
                                strengthDescription = ""
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
                                    .foregroundStyle(Color(.myPink))
                            }.toggleStyle(.switch).tint(Color(.myPink))

                            Toggle(isOn: $isEmptySpaceOn) {
                                Text(K.Strings.passwordIncludeEmptySpace)
                                    .foregroundStyle(Color(.myGray))
                            }.toggleStyle(.switch).tint(Color(.myGray))
                        }

                        Button {
                            characters = viewModel.generatePassword(lenght: Int(charCount), specialCharacters: isSymbolsOn, uppercase: hasUpperCase, numbers: isNumbersOn, emptySpace: isEmptySpaceOn)
                            generatedPassword = characters.joined()
                            generatedPasswordEntropy = viewModel.passwordStrenghtCalculator(password: characters.joined())
                            strenghtText(entropy: generatedPasswordEntropy)
                        } label: {
                            Image(systemName: K.Image.wandAndStars)
                                .imageScale(.large)
                            Text(K.Strings.generatePassword)
                        }
                        .buttonStyle(.borderless)
                        .frame(maxWidth: .infinity, maxHeight: 0, alignment: .center)
                        .padding()

                        Section {
                            HStack(spacing: 0.3) {
                                if generatedPassword.isEmpty {
                                    Text(K.Strings.password)
                                        .foregroundStyle(Color(.myGray))
                                } else {
                                    ForEach(characters, id: \.self) { character in
                                        Text(character)
                                            .foregroundColor(viewModel.specialCharactersArray.contains(character) ? Color(.myBlue) : viewModel.numbersArray.contains(character) ? Color(.myOrange) : viewModel.alphabet.contains(character) ? Color(.myGray) : Color(.myPink))
                                            .font(charCount > 25 ? .system(size: 15) : .body)
                                    }
                                }
                                Spacer()


                            }
                            .overlay(alignment: .trailing) {
                                Button {
                                    clipboardString.copyToClipboard(string: generatedPassword)

                                    withAnimation {
                                        copied = true
                                    }
                                } label: {
                                    Image(systemName: K.Image.docOndoc)
                                        .imageScale(.large)
                                        .padding(.trailing, -10)
                                }
                                .buttonStyle(.borderless).controlSize(.large)
                            }

                            if copied {
                                ToastView(toastMessage: K.Strings.clipboardPasswordMessage, copied: copied)
                            }

                            EmptyView()

                            PasswordStrengthView(description: $strengthDescription, entropy: generatedPasswordEntropy)
                                .foregroundStyle(strengthColor(entropy: generatedPasswordEntropy))
                        }
                    }
                }
                .navigationTitle(K.Strings.passwordGeneratorNavTitle)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

extension PasswordGeneratorView {
    func strenghtText(entropy: Double) {
        switch entropy {
        case 128.0...200:
            strengthDescription = PasswordStrengthDescription.excellent.rawValue
        case 60.0...128:
            strengthDescription = PasswordStrengthDescription.veryGood.rawValue
        case 36.0...60:
            strengthDescription = PasswordStrengthDescription.reasonable.rawValue
        case 28.0...36:
            strengthDescription = PasswordStrengthDescription.weak.rawValue
        default:
            strengthDescription = PasswordStrengthDescription.veryWeak.rawValue
        }
    }

    func strengthColor(entropy: Double) -> Color {
        switch entropy {
        case 128.0...200:
            return Color(.myBlue)
        case 60.0...128:
            return Color(.myGreen)
        case 36.0...60:
            return Color(.myYellow)
        case 28.0...36:
            return Color(.myOrange)
        default:
            return Color(.myRed)
        }
    }
}

#Preview {
    PasswordGeneratorView()
}
