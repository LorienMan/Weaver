/// This file is generated by Weaver 0.9.3
/// DO NOT EDIT!
import Weaver
// MARK: - PersonManager
protocol PersonManagerDependencyResolver {
    var logger: Logger { get }
    var movieAPI: APIProtocol { get }
}
protocol PersonManagerDependencyInjectable {
    init(injecting dependencies: PersonManagerDependencyResolver)
}
extension PersonManager: PersonManagerDependencyInjectable {}