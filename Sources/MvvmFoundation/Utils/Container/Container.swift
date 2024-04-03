//
//  Container.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

public struct ContainerKey: Codable {
    let key: String
    let isDefault: Bool

    public init(key: String, isDefault: Bool = false) {
        self.key = key
        self.isDefault = isDefault
    }

    internal var value: String {
        isDefault ? "" : key
    }
}

public extension ContainerKey {
    static var `default`: ContainerKey {.init(key: "default") }
}

public class Container {
    private var map = [String: HolderProtocol]()
}

// MARK: - Register
public extension Container {
    // MARK: - Multiresolved
    func register<T: Any>(type: T.Type = T.self, key: ContainerKey? = nil, factory: @escaping () -> T) {
        map[String(describing: type) + (key?.value ?? "")] = ResolverHolder(factory: factory)
    }

    // MARK: - Singleton
    func registerSingleton<T: Any>(type: T.Type = T.self, key: ContainerKey? = nil, factory: @escaping () -> T) {
        map[String(describing: type) + (key?.value ?? "")] = SingletonHolder(factory: factory)
    }

    // MARK: - Daemon
    func registerDaemon<T: Any>(type: T.Type = T.self, key: ContainerKey? = nil, factory: @escaping () -> T) {
        let holder = SingletonHolder(factory: factory)
        map[String(describing: type) + (key?.value ?? "")] = holder
        _ = holder.getter
    }

    // MARK: - Weak
    func registerWeak<T: AnyObject>(type: T.Type = T.self, key: ContainerKey? = nil, factory: @escaping () -> T) {
        map[String(describing: type) + (key?.value ?? "")] = WeakHolder(factory: factory)
    }
}

// MARK: - Safe Resolve
public extension Container {
    func safeResolve<T: Any>(type: T.Type = T.self, key: ContainerKey? = nil) -> T? {
        guard let obj = safeResolve(id: String(describing: type), key: key) as T?
        else { return nil }

        return obj
    }

    func safeResolve<T: Any>(id: String, key: ContainerKey? = nil) -> T? {
        guard let obj = map[id + (key?.value ?? "")]?.getter as? T
        else { return nil }

        return obj
    }
}

// MARK: - Resolve
public extension Container {
    func resolve<T: Any>(type: T.Type = T.self, key: ContainerKey? = nil) -> T {
        resolve(id: String(describing: type), key: key) as T
    }

    func resolve<T: Any>(id: String, key: ContainerKey? = nil) -> T {
        guard let obj = safeResolve(id: id, key: key) as T?
        else { fatalError("\(T.self) is not registered") }

        return obj
    }
}
