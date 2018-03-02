//
//  LexerTests.swift
//  BeaverDICodeGenTests
//
//  Created by Théophane Rupin on 2/22/18.
//

import Foundation
import XCTest
import SourceKittenFramework

@testable import BeaverDICodeGen

final class LexerTests: XCTestCase {
    
    func testTokenizeShouldProvideAFullTokenList() {
        
        let file = File(contents: """
// beaverdi: parent = MainDependencyResolver
// regular comment
final class MyService {
  let dependencies: DependencyResolver

  // beaverdi: api -> APIProtocol
  // beaverdi: api.scope = .graph

  // beaverdi: router -> RouterProtocol
  // beaverdi: router.scope = .parent

  // beaverdi: parent = MyServiceDependencyResolver
  final class MyEmbeddedService {

    // beaverdi: session -> SessionProtocol?
    // beaverdi: session.scope = .container
  }

  init(_ dependencies: DependencyResolver) {
    self.dependencies = dependencies
  }
}
""")
        let lexer = Lexer(file)
        let tokens = try! lexer.tokenize()
        
        XCTAssertEqual(tokens.count, 16)
        guard tokens.count == 16 else { return }

        XCTAssertEqual(tokens[0] as? Token<ParentResolverAnnotation>, Token(type: ParentResolverAnnotation(type: "MainDependencyResolver"), offset: 0, length: 45, line: 0))
        XCTAssertEqual(tokens[1] as? Token<InjectableType>, Token(type: InjectableType(), offset: 70, length: 474, line: 2))
        XCTAssertEqual(tokens[2] as? Token<AnyDeclaration>, Token(type: AnyDeclaration(), offset: 90, length: 36, line: 3))
        XCTAssertEqual(tokens[3] as? Token<RegisterAnnotation>, Token(type: RegisterAnnotation(name: "api", type: "APIProtocol"), offset: 130, length: 32, line: 5))
        XCTAssertEqual(tokens[4] as? Token<ScopeAnnotation>, Token(type: ScopeAnnotation(name: "api", scope: .graph), offset: 164, length: 32, line: 6))
        XCTAssertEqual(tokens[5] as? Token<RegisterAnnotation>, Token(type: RegisterAnnotation(name: "router", type: "RouterProtocol"), offset: 199, length: 38, line: 8))
        XCTAssertEqual(tokens[6] as? Token<ScopeAnnotation>, Token(type: ScopeAnnotation(name: "router", scope: .parent), offset: 239, length: 36, line: 9))
        XCTAssertEqual(tokens[7] as? Token<ParentResolverAnnotation>, Token(type: ParentResolverAnnotation(type: "MyServiceDependencyResolver"), offset: 278, length: 50, line: 11))
        XCTAssertEqual(tokens[8] as? Token<InjectableType>, Token(type: InjectableType(), offset: 336, length: 119, line: 12))
        XCTAssertEqual(tokens[9] as? Token<RegisterAnnotation>, Token(type: RegisterAnnotation(name: "session", type: "SessionProtocol?"), offset: 367, length: 41, line: 14))
        XCTAssertEqual(tokens[10] as? Token<ScopeAnnotation>, Token(type: ScopeAnnotation(name: "session", scope: .container), offset: 412, length: 40, line: 15))
        XCTAssertEqual(tokens[11] as? Token<EndOfInjectableType>, Token(type: EndOfInjectableType(), offset: 454, length: 1, line: 16))
        XCTAssertEqual(tokens[12] as? Token<AnyDeclaration>, Token(type: AnyDeclaration(), offset: 459, length: 83, line: 18))
        XCTAssertEqual(tokens[13] as? Token<AnyDeclaration>, Token(type: AnyDeclaration(), offset: 464, length: 34, line: 18))
        XCTAssertEqual(tokens[14] as? Token<EndOfAnyDeclaration>, Token(type: EndOfAnyDeclaration(), offset: 541, length: 1, line: 20))
        XCTAssertEqual(tokens[15] as? Token<EndOfInjectableType>, Token(type: EndOfInjectableType(), offset: 543, length: 1, line: 21))
    }
    
    func testTokenizerShouldThrowAnErrorWithTheRightLineAndContentOnARegisterRule() {
        
        let file = File(contents: """
// beaverdi: parent = MainDependencyResolver
final class MyService {
  let dependencies: DependencyResolver

  // beaverdi: api --> APIProtocol
  // beaverdi: api.scope = .graph

  init(_ dependencies: DependencyResolver) {
    self.dependencies = dependencies
  }

  func doSomething() {
    otherService.doSomething(in: api).then { result in
      if let session = self.session {
        router.redirectSomewhereWeAreLoggedIn()
      } else {
        router.redirectSomewhereWeAreLoggedOut()
      }
    }
  }
}
""")
        let lexer = Lexer(file)

        do {
            _ = try lexer.tokenize()
            XCTAssertTrue(false, "Haven't thrown any error.")
        } catch Lexer.Error.invalidAnnotation(let line, .invalidAnnotation(let content)) {
            XCTAssertEqual(line, 4)
            XCTAssertEqual(content, "beaverdi: api --> APIProtocol")
        } catch {
            XCTAssertTrue(false, "Unexpected error: \(error).")
        }
    }
    
    func testTokenizerShouldThrowAnErrorWithTheRightLineAndContentOnAScopeRule() {
        
        let file = File(contents: """
// beaverdi: parent = MainDependencyResolver
final class MyService {
  let dependencies: DependencyResolver

  // beaverdi: api -> APIProtocol
  // beaverdi: api.scope = .thisScopeDoesNotExists

  init(_ dependencies: DependencyResolver) {
    self.dependencies = dependencies
  }

  func doSomething() {
    otherService.doSomething(in: api).then { result in
      if let session = self.session {
        router.redirectSomewhereWeAreLoggedIn()
      } else {
        router.redirectSomewhereWeAreLoggedOut()
      }
    }
  }
}
""")
        let lexer = Lexer(file)
        
        do {
            _ = try lexer.tokenize()
            XCTAssertTrue(false, "Haven't thrown any error.")
        } catch Lexer.Error.invalidAnnotation(let line, .invalidScope(let scope)) {
            XCTAssertEqual(line, 5)
            XCTAssertEqual(scope, "thisScopeDoesNotExists")
        } catch {
            XCTAssertTrue(false, "Unexpected error: \(error).")
        }
    }
}

