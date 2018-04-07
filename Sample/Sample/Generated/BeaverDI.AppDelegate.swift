/// This file is generated by BeaverDI
/// DO NOT EDIT!

import BeaverDI

// MARK: - AppDelegate

final class AppDelegateDependencyContainer: DependencyContainer {

    
    init() {
        super.init()
    }

    override func registerDependencies(in store: DependencyStore) {
        
        store.register(MovieManaging.self, scope: .container, name: "movieManager", builder: { (dependencies) in
            return MovieManager.makeMovieManager(injecting: dependencies)
        })
        store.register(URLSession.self, scope: .container, name: "urlSession", builder: { (dependencies) in
            return self.urlSessionCustomRef(dependencies)
        })
        store.register(APIProtocol.self, scope: .container, name: "movieAPI", builder: { (dependencies) in
            return MovieAPI.makeMovieAPI(injecting: dependencies)
        })
        store.register(HomeViewController.self, scope: .container, name: "homeViewController", builder: { (dependencies) in
            return HomeViewController.makeHomeViewController(injecting: dependencies)
        })
    }
}

protocol AppDelegateDependencyResolver {
    
    
    var movieManager: MovieManaging { get }
    var urlSession: URLSession { get }
    var movieAPI: APIProtocol { get }
    var homeViewController: HomeViewController { get }
    func urlSessionCustomRef(_ dependencies: DependencyContainer) -> URLSession
    
}

extension AppDelegateDependencyContainer: AppDelegateDependencyResolver {
    
    var movieManager: MovieManaging {
        return resolve(MovieManaging.self, name: "movieManager")
    }
    var urlSession: URLSession {
        return resolve(URLSession.self, name: "urlSession")
    }
    var movieAPI: APIProtocol {
        return resolve(APIProtocol.self, name: "movieAPI")
    }
    var homeViewController: HomeViewController {
        return resolve(HomeViewController.self, name: "homeViewController")
    }
}
