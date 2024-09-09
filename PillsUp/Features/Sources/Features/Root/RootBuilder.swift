//
//  RootBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit
import Domain

public protocol RootDependency: Dependency {
    var distanceSettingUseCase: DistanceSettingUseCase { get }
}

final class RootComponent: Component<RootDependency> {
    var distanceSettingUseCase: DistanceSettingUseCase {
        return dependency.distanceSettingUseCase
    }
}

// MARK: - Builder

public protocol RootBuildable: Buildable {
    func build(_ navigationController: UINavigationController) -> LaunchRouting
}

public final class RootBuilder: Builder<RootDependency>, RootBuildable {

    public override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    public func build(_ navigationController: UINavigationController) -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController(navigation: navigationController)
        let interactor = RootInteractor(presenter: viewController)
        
        let mainBuilder = MainBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuilder: mainBuilder
        )
    }
}