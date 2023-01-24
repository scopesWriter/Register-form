//
//  extensions .swift
//  SwiftUI Arena
//
//  Created by Bishoy Badea [Pharma] on 24/01/2023.
//

import Foundation

extension String {
    // MARK: - Is Valid Name
    var isValidName: Bool {
        !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        self.split(separator: " ").count > 1 &&
        self.split(separator: " ").map { String($0).count }.allSatisfy { $0 > 2 } &&
        self.rangeOfCharacter(from: .decimalDigits) == nil  &&
        self.rangeOfCharacter(from: .punctuationCharacters) == nil &&
        self.rangeOfCharacter(from: .symbols) == nil
    }
    
    // MARK: - Is .com Email
    func isDotComEmail() -> Bool {
        return self.isValidEmail && self.hasSuffix(".com")
    }
    
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        return self.compare(otherVersion, options: .numeric)
    }
    
    var firstLetterCapitalized: String {
        return prefix(1).capitalized + dropFirst().lowercased()
    }
    
}

// as time interval format
extension String {
    
    enum Format {
        case ago
        case meduimShort
    }
    
    func convertToTimeInterval() -> TimeInterval {
        guard self != "" else {
            return 0
        }

        var interval: Double = 0

        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        return interval
    }
    
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}



public extension String{
   
   //MARK: Check for Valid Email
   var isValidEmail: Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: self)
   }
   
   var hasValue: Bool {
       !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
   }
   
   var isValidMobileNumber : Bool {
       let prefixes = ["010","011","012","015"]
       return prefixes.contains(where: self.hasPrefix) && self.count == 11 && self.isNumbersOnly()
   }
   
   func isNumbersOnly() -> Bool {
       do {
           let regexNumbersOnly = try NSRegularExpression(pattern: ".*[^0-9].*", options: [])
           let success = regexNumbersOnly.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) == nil
           return success
       } catch let error as NSError {
           print(error.description)
           return false
       }
   }
   
   var localize: String {
       return NSLocalizedString(self, comment: "")
   }
   
   func numberOfOccurrencesOf(string: String) -> Int {
         return self.components(separatedBy:string).count - 1
   }
}

