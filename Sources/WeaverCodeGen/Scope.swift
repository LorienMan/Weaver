//
//  Scope.swift
//  WeaverCodeGen
//
//  Created by Théophane Rupin on 2/20/18.
//

import Foundation

/// Enum representing the scope of an instance.
///
/// Possible cases:
/// - transient: the `DependencyContainer` always creates a new instance when the type is resolved.
/// - container: builds an instance at initialization of its container and keeps it for the lifetime its container.
/// - weak: a new instance is created when resolved the first time and then lives for the time its strong references are living and shared with children.
/// - lazy: a new instance is created when resolved the first time and has the same lifetime than its container.
public enum Scope: String, CaseIterable {
    case transient
    case container
    case weak
    case lazy
    
    static var `default`: Scope {
        return .container
    }
}
