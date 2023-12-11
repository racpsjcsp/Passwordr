//
//  PasswordGeneratorViewModel.swift
//  Passwordr
//
//  Created by Rafael Plinio on 05/12/23.
//

import Foundation

class PasswordGeneratorViewModel: ObservableObject {
    @Published var generatedPassword = [String]()

    let alphabet: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    let specialCharactersArray: [String] = ["(",")","{","}","[","]","/","\\","-","_","+","*","$",">",".","|","^","?","&","%","#","@","!","?","˜"]
    let numbersArray: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    func generatePassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        //The order of the conditions must be respected. Descending order (all (four), three, two, one)

        ///All parameters (four)
        if uppercase && specialCharacters && numbers && emptySpace {
            return fourParameterPassword(lenght: lenght)
        }

        ///Three parameters
        if uppercase && specialCharacters && numbers || uppercase && specialCharacters && emptySpace || uppercase && numbers && emptySpace || numbers && specialCharacters && emptySpace {
            return threeParameterPassword(lenght: lenght, specialCharacters: specialCharacters, uppercase: uppercase, numbers: numbers, emptySpace: emptySpace)
        }

        /// Two parameters
        if uppercase && specialCharacters || uppercase && numbers || numbers && specialCharacters || uppercase && emptySpace || numbers && emptySpace || specialCharacters && emptySpace {
            return twoParameterPassword(lenght: lenght, specialCharacters: specialCharacters, uppercase: uppercase, numbers: numbers, emptySpace: emptySpace)
        }

        ///One parameter
        if uppercase || specialCharacters || numbers || emptySpace {
            return oneParameterPassword(lenght: lenght, specialCharacters: specialCharacters, uppercase: uppercase, numbers: numbers, emptySpace: emptySpace)
        }

        else {
            return zeroParameterPassword(lenght: lenght)
        }
    }

    private func zeroParameterPassword(lenght: Int) -> [String] {
        var password: [String] = [""]

        for _ in 0...lenght {
            password.append(alphabet.randomElement()!)
        }

        return assemblePassword(password: password, lenght: lenght, hasParameter: false, hasNumber: false, hasSymbol: false, hasEmpty: false, hasUpper: false)
    }

    private func oneParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        let assembledLowercasePassword = lowercaseCharacters(lenght: lenght, parameterCount: 1+1)
        let assembledSpecialCharacters = getSpecialCharacters(password: password, lenght: lenght, parameterCount: 1+1)
        let assembledNumberCharacters = getNumberCharacters(password: password, lenght: lenght, parameterCount: 1+1)
        let assembledEmptySpaces = getEmptySpaces(password: password, lenght: lenght, parameterCount: 1+1)
        let assembledUppercaseCharacters = getUppercaseCharacters(password: password, lenght: lenght, parameterCount: 1+1)

        if specialCharacters {
            password = [assembledLowercasePassword, assembledSpecialCharacters].flatMap({ $0 })
        }

        if uppercase {
            password = [assembledLowercasePassword, assembledUppercaseCharacters].flatMap({ $0 })
        }

        if numbers {
            password = [assembledLowercasePassword, assembledNumberCharacters].flatMap({ $0 })
        }

        if emptySpace {
            password = [assembledLowercasePassword, assembledEmptySpaces].flatMap({ $0 })
        }

        return assemblePassword(password: password, lenght: lenght, hasParameter: true, hasNumber: numbers, hasSymbol: specialCharacters, hasEmpty: emptySpace, hasUpper: uppercase)
    }

    private func twoParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        let assembledLowercasePassword = lowercaseCharacters(lenght: lenght, parameterCount: 2+1)
        let assembledSpecialCharacters = getSpecialCharacters(password: password, lenght: lenght, parameterCount: 2+1)
        let assembledNumberCharacters = getNumberCharacters(password: password, lenght: lenght, parameterCount: 2+1)
        let assembledEmptySpaces = getEmptySpaces(password: password, lenght: lenght, parameterCount: 2+1)
        let assembledUppercaseCharacters = getUppercaseCharacters(password: password, lenght: lenght, parameterCount: 2+1)

        if uppercase && specialCharacters {
            password = [assembledLowercasePassword, assembledUppercaseCharacters, assembledSpecialCharacters].flatMap({ $0 })
        }

        if uppercase && numbers {
            password = [assembledLowercasePassword, assembledUppercaseCharacters, assembledNumberCharacters].flatMap({ $0 })
        }

        if numbers && specialCharacters {
            password = [assembledLowercasePassword, assembledNumberCharacters, assembledSpecialCharacters].flatMap({ $0 })
        }

        if numbers && emptySpace {
            password = [assembledLowercasePassword, assembledNumberCharacters, assembledEmptySpaces].flatMap({ $0 })
        }

        if specialCharacters && emptySpace {
            password = [assembledLowercasePassword, assembledSpecialCharacters, assembledEmptySpaces].flatMap({ $0 })
        }

        if uppercase && emptySpace {
            password = [assembledLowercasePassword, assembledUppercaseCharacters, assembledEmptySpaces].flatMap({ $0 })
        }

        return assemblePassword(password: password, lenght: lenght, hasParameter: true, hasNumber: numbers, hasSymbol: specialCharacters, hasEmpty: emptySpace, hasUpper: uppercase)
    }

    private func threeParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        let assembledLowercasePassword = lowercaseCharacters(lenght: lenght, parameterCount: 3+1)
        let assembledSpecialCharacters = getSpecialCharacters(password: password, lenght: lenght, parameterCount: 3+1)
        let assembledNumberCharacters = getNumberCharacters(password: password, lenght: lenght, parameterCount: 3+1)
        let assembledEmptySpaces = getEmptySpaces(password: password, lenght: lenght, parameterCount: 3+1)
        let assembledUppercaseCharacters = getUppercaseCharacters(password: password, lenght: lenght, parameterCount: 3+1)

        if specialCharacters && uppercase && numbers {
            password = [assembledLowercasePassword, assembledSpecialCharacters, assembledUppercaseCharacters, assembledNumberCharacters].flatMap({ $0 })
        }

        if specialCharacters && uppercase && emptySpace {
            password = [assembledLowercasePassword, assembledSpecialCharacters, assembledUppercaseCharacters, assembledEmptySpaces].flatMap({ $0 })
        }

        if numbers && uppercase && emptySpace {
            password = [assembledLowercasePassword, assembledNumberCharacters, assembledUppercaseCharacters, assembledEmptySpaces].flatMap({ $0 })
        }

        if numbers && specialCharacters && emptySpace {
            password = [assembledLowercasePassword, assembledNumberCharacters, assembledSpecialCharacters, assembledEmptySpaces].flatMap({ $0 })
        }
        
        return assemblePassword(password: password, lenght: lenght, hasParameter: true, hasNumber: numbers, hasSymbol: specialCharacters, hasEmpty: emptySpace, hasUpper: uppercase)
    }

    private func fourParameterPassword(lenght: Int) -> [String] {
        var password: [String] = [""]
        let assembledLowercasePassword = lowercaseCharacters(lenght: lenght, parameterCount: 4+1)
        let assembledSpecialCharacters = getSpecialCharacters(password: password, lenght: lenght, parameterCount: 4+1)
        let assembledNumberCharacters = getNumberCharacters(password: password, lenght: lenght, parameterCount: 4+1)
        let assembledEmptySpaces = getEmptySpaces(password: password, lenght: lenght, parameterCount: 4+1)
        let assembledUppercaseCharacters = getUppercaseCharacters(password: password, lenght: lenght, parameterCount: 4+1)

        password = [assembledLowercasePassword, assembledSpecialCharacters, assembledNumberCharacters,
                    assembledEmptySpaces, assembledUppercaseCharacters].flatMap({ $0})

        return assemblePassword(password: password, lenght: lenght, hasParameter: true, hasNumber: true, hasSymbol: true, hasEmpty: true, hasUpper: true)
    }

    private func lowercaseCharacters(lenght: Int, parameterCount: Int) -> [String] {
        var password: [String] = [""]

        for _ in 0...lenght/parameterCount {
            password.append(alphabet.randomElement()!)
        }

        return lowercasePassword(password: password, lenght: lenght)
    }

    private func getSpecialCharacters(password: [String], lenght: Int, parameterCount: Int) -> [String] {
        var pass = password

        for _ in 0...lenght/parameterCount {
            pass.append(specialCharactersArray.randomElement()!)
        }

        return pass
    }

    private func getNumberCharacters(password: [String], lenght: Int, parameterCount: Int) -> [String] {
        var pass = password

        for _ in 0...lenght/parameterCount {
            pass.append(numbersArray.randomElement()!)
        }

        return pass
    }

    private func getUppercaseCharacters(password: [String], lenght: Int, parameterCount: Int) -> [String] {
        var pass = password

        for _ in 0...lenght/parameterCount {
            pass.append(alphabet.randomElement()!.uppercased())
        }

        return pass
    }

    private func getEmptySpaces(password: [String], lenght: Int, parameterCount: Int) -> [String] {
        var pass = password
        let emptySpace = " "

        for _ in 0...lenght/parameterCount {
            pass.append(emptySpace)
        }

        return pass
    }

    private func assemblePassword(password: [String], lenght: Int, hasParameter: Bool, hasNumber: Bool, hasSymbol: Bool, hasEmpty: Bool, hasUpper: Bool) -> [String] {
        var pass = lowercasePassword(password: password, lenght: lenght)

        if hasParameter {
            for _ in password {
                while password.joined().count < lenght {
                    if hasNumber {
                        pass.append(numbersArray.randomElement()!)
                    } else if hasSymbol {
                        pass.append(specialCharactersArray.randomElement()!)
                    } else if hasUpper {
                        pass.append(alphabet.randomElement()!.uppercased())
                    } else if hasEmpty {
                        pass.append(" ")
                    } else {
                        pass.append(alphabet.randomElement()!)
                    }
                }
            }
        }

        pass.shuffle()
        return pass
    }

    private func lowercasePassword(password: [String], lenght: Int) -> [String] {
        var pass = password

        if pass.joined().count != lenght {
            while pass.joined().count > lenght {
                pass.shuffle()
                pass.remove(at: 0)
            }
        }

        return pass
    }
}
