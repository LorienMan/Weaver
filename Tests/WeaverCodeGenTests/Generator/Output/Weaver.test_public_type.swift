/// This file is generated by Weaver 0.10.3
/// DO NOT EDIT!
// MARK: - FooTest7
protocol FooTest7InputDependencyResolver {
    var fii: FiiTest7 { get }
}
protocol FooTest7DependencyResolver {
    var fee: FeeTest7 { get }
    var fii: FiiTest7 { get }
    var fuu: FuuTest7 { get }
}
final class FooTest7DependencyContainer: FooTest7DependencyResolver {
    let fee: FeeTest7
    let fii: FiiTest7
    private var _fuu: FuuTest7?
    var fuu: FuuTest7 {
        if let value = _fuu { return value }
        let value = FuuTest7()
        _fuu = value
        return value
    }
    init(injecting dependencies: FooTest7InputDependencyResolver, fee: FeeTest7) {
        self.fee = fee
        fii = dependencies.fii
        _ = fuu
    }
}
final class FooTest7ShimDependencyContainer: FooTest7InputDependencyResolver {
    let fii: FiiTest7
    init(fii: FiiTest7) {
        self.fii = fii
    }
}
extension FooTest7 {
    public convenience init(fii: FiiTest7, fee: FeeTest7) {
        let shim = FooTest7ShimDependencyContainer(fii: fii)
        let dependencies = FooTest7DependencyContainer(injecting: shim, fee: fee)
        self.init(injecting: dependencies)
    }
}
