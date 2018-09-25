/// This file is generated by Weaver 0.10.3
/// DO NOT EDIT!
// MARK: - FaaTest11
protocol FaaTest11InputDependencyResolver {
    var fuu: FuuTest11 { get }
}
protocol FaaTest11DependencyResolver {
    var fuu: FuuTest11 { get }
    var fee: FeeTest11 { get }
}
final class FaaTest11DependencyContainer: FaaTest11DependencyResolver {
    let fuu: FuuTest11
    var fee: FeeTest11 {
        let dependencies = FeeTest11DependencyContainer(injecting: self)
        let value = FeeTest11(injecting: dependencies)
        return value
    }
    init(injecting dependencies: FaaTest11InputDependencyResolver) {
        fuu = dependencies.fuu
    }
}
extension FaaTest11DependencyContainer: FeeTest11InputDependencyResolver {}
// MARK: - FeeTest11
protocol FeeTest11InputDependencyResolver {
    var fuu: FuuTest11 { get }
}
protocol FeeTest11DependencyResolver {
    var fuu: FuuTest11 { get }
    var fii: FiiTest11 { get }
}
final class FeeTest11DependencyContainer: FeeTest11DependencyResolver {
    let fuu: FuuTest11
    var fii: FiiTest11 {
        let dependencies = FiiTest11DependencyContainer(injecting: self)
        let value = FiiTest11(injecting: dependencies)
        return value
    }
    init(injecting dependencies: FeeTest11InputDependencyResolver) {
        fuu = dependencies.fuu
    }
}
extension FeeTest11DependencyContainer: FiiTest11InputDependencyResolver {}
// MARK: - FiiTest11
protocol FiiTest11InputDependencyResolver {
    var fuu: FuuTest11 { get }
}
protocol FiiTest11DependencyResolver {
    var fuu: FuuTest11 { get }
}
final class FiiTest11DependencyContainer: FiiTest11DependencyResolver {
    let fuu: FuuTest11
    init(injecting dependencies: FiiTest11InputDependencyResolver) {
        fuu = dependencies.fuu
    }
}
// MARK: - FooTest11
protocol FooTest11DependencyResolver {
    var fuu: FuuTest11 { get }
    var faa: FaaTest11 { get }
}
final class FooTest11DependencyContainer: FooTest11DependencyResolver {
    private var _fuu: FuuTest11?
    var fuu: FuuTest11 {
        if let value = _fuu { return value }
        let value = FuuTest11()
        _fuu = value
        return value
    }
    private var _faa: FaaTest11?
    var faa: FaaTest11 {
        if let value = _faa { return value }
        let dependencies = FaaTest11DependencyContainer(injecting: self)
        let value = FaaTest11(injecting: dependencies)
        _faa = value
        return value
    }
    init() {
        _ = fuu
        _ = faa
    }
}
extension FooTest11DependencyContainer: FaaTest11InputDependencyResolver {}
