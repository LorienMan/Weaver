//
//  Type.swift
//  WeaverCodeGen
//
//  Created by Théophane Rupin on 6/22/18.
//

import Foundation

/// Representation of any Swift type
public struct Type: Hashable, Equatable {

    /// Type name
    public let name: String
    
    /// Names of the generic parameters
    public let genericNames: [String]
    
    public let isOptional: Bool
    
    public let generics: String
    
    init?(_ string: String) throws {
        if let matches = try NSRegularExpression(pattern: "^(\(Patterns.genericType))$").matches(in: string) {
            let name = matches[1]
            
            let isOptional = matches[0].hasSuffix("?")
            
            let genericNames: [String]
            if matches.count > 2 {
                let characterSet = CharacterSet.whitespaces.union(CharacterSet(charactersIn: "<>,"))
                genericNames = matches[2]
                    .split(separator: ",")
                    .map { $0.trimmingCharacters(in: characterSet) }
            } else {
                genericNames = []
            }
            
            self.init(name: name, genericNames: genericNames, isOptional: isOptional)
        } else if let matches = try NSRegularExpression(pattern: "^(\(Patterns.arrayType))$").matches(in: string) {
            let name = "Array"
            let isOptional = matches[0].hasSuffix("?")
            let genericNames = [matches[1]]
            self.init(name: name, genericNames: genericNames, isOptional: isOptional)
        } else if let matches = try NSRegularExpression(pattern: "^(\(Patterns.dictType))$").matches(in: string) {
            let name = "Dictionary"
            let isOptional = matches[0].hasSuffix("?")
            let genericNames = [matches[1], matches[2]]
            self.init(name: name, genericNames: genericNames, isOptional: isOptional)
        } else {
            return nil
        }
    }
    
    init(name: String,
         genericNames: [String] = [],
         isOptional: Bool = false) {

        self.name = name
        self.genericNames = genericNames
        self.isOptional = isOptional
        
        generics = "\(genericNames.isEmpty ? "" : "<\(genericNames.joined(separator: ", "))>")"
    }
}

// MARK: - Index

struct TypeIndex: Hashable, Equatable {

    let value: String
    
    init(type: Type) {
        value = "\(type.name)\(type.isOptional ? "?" : "")"
    }
}

// MARK: - Description

extension Type: CustomStringConvertible {
    
    public var description: String {
        return "\(name)\(generics)\(isOptional ? "?" : "")"
    }
    
    var indexKey: String {
        return "\(name)\(isOptional ? "?" : "")"
    }
    
    var index: TypeIndex {
        return TypeIndex(type: self)
    }
}
