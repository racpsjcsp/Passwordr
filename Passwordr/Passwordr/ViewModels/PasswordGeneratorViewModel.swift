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
    let emptySpace = " "

    func generatePassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        //The order of the conditions must be respected. Descending order (all (four), three, two, one)
        ///All parameters
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
            return lowercasePassword(lenght: lenght)
        }
    }

    private func lowercasePassword(lenght: Int) -> [String] {
        var password: [String] = [""]

        for _ in 0...lenght {
            password.append(alphabet.randomElement()!)
        }

        if password.joined().count != lenght {
            while password.joined().count > lenght {
                password.remove(at: 0)
            }
        }
        return password
    }

    private func oneParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        var uppercasedAlphabet: [String] = []

        for character in alphabet {
            uppercasedAlphabet.append(character.uppercased())
        }

        if specialCharacters {
            for _ in 0...lenght / 2 {
                password.append(alphabet.randomElement()!)
            }

            for _ in 0...lenght / 2 {
                password.append(specialCharactersArray.randomElement()!)
            }
            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }

            return password
        }

        if uppercase {
            for _ in 0...lenght / 2 {
                password.append(alphabet.randomElement()!)
            }

            for _ in 0...lenght / 2 {
                password.append(uppercasedAlphabet.randomElement()!)
            }
            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if numbers {
            for _ in 0...lenght / 2 {
                password.append(alphabet.randomElement()!)
            }

            for _ in 0...lenght / 2 {
                password.append(numbersArray.randomElement()!)
            }
            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if emptySpace {
            for _ in 0...lenght / 2 {
                password.append(alphabet.randomElement()!)
            }

            for _ in 0...lenght / 2 {
                password.append(self.emptySpace)
            }
            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        return password
    }

    private func twoParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        var uppercasedAlphabet: [String] = []

        for character in alphabet {
            uppercasedAlphabet.append(character.uppercased())
        }

        if uppercase && specialCharacters {

            for _ in 0...lenght / 3 {
                password.append(uppercasedAlphabet.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(specialCharactersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if uppercase && numbers {

            for _ in 0...lenght / 3 {
                password.append(uppercasedAlphabet.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(numbersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if numbers && specialCharacters {

            for _ in 0...lenght / 3 {
                password.append(numbersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(specialCharactersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if numbers && emptySpace {

            for _ in 0...lenght / 3 {
                password.append(numbersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(self.emptySpace)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if specialCharacters && emptySpace {

            for _ in 0...lenght / 3 {
                password.append(specialCharactersArray.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(self.emptySpace)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }

        if uppercase && emptySpace {

            for _ in 0...lenght / 3 {
                password.append(uppercasedAlphabet.randomElement()!)
            }

            for _ in 0...lenght / 3 {
                password.append(self.emptySpace)
            }

            for _ in 0...lenght / 3 {
                password.append(alphabet.randomElement()!)
            }

            password.shuffle()

            if password.joined().count != lenght {
                while password.joined().count > lenght {
                    password.remove(at: 0)
                }
            }
            return password
        }
        
        return password
    }

    private func threeParameterPassword(lenght: Int, specialCharacters: Bool, uppercase: Bool, numbers: Bool, emptySpace: Bool) -> [String] {
        var password: [String] = [""]
        var uppercasedAlphabet: [String] = []

        for character in alphabet {
            uppercasedAlphabet.append(character.uppercased())
        }

        for _ in 0...lenght / 4 {
            password.append(uppercasedAlphabet.randomElement()!)
        }

        for _ in 0...lenght / 4 {
            password.append(specialCharactersArray.randomElement()!)
        }

        for _ in 0...lenght / 4 {
            password.append(alphabet.randomElement()!)
        }

        for _ in 0...lenght / 4 {
            password.append(numbersArray.randomElement()!)
        }

        for _ in 0...lenght / 4 {
            password.append(self.emptySpace)
        }

        password.shuffle()

        if password.joined().count != lenght {
            while password.joined().count > lenght {
                password.remove(at: 0)
            }
        }

        return password
    }

    private func fourParameterPassword(lenght: Int) -> [String] {
        var password: [String] = [""]
        var uppercasedAlphabet: [String] = []

        for character in alphabet {
            uppercasedAlphabet.append(character.uppercased())
        }

        for _ in 0...lenght / 5 {
            password.append(uppercasedAlphabet.randomElement()!)
        }

        for _ in 0...lenght / 5 {
            password.append(specialCharactersArray.randomElement()!)
        }

        for _ in 0...lenght / 5 {
            password.append(alphabet.randomElement()!)
        }

        for _ in 0...lenght / 5 {
            password.append(numbersArray.randomElement()!)
        }

        for _ in 0...lenght / 5 {
            password.append(self.emptySpace)
        }

        password.shuffle()

        if password.joined().count != lenght {
            while password.joined().count > lenght {
                password.remove(at: 0)
            }
        }

        return password
    }
}
