/// This file is generated by Weaver 0.10.3
/// DO NOT EDIT!
// MARK: - FooTest8
protocol FooTest8DependencyResolver {
    var fuu: UInt { get }
}
final class FooTest8DependencyContainer: FooTest8DependencyResolver {
    let fuu: UInt
    init(fuu: UInt) {
        self.fuu = fuu
    }
}
