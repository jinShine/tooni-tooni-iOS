//
//  SceneDelegate.swift
//  toonitooni
//
//  Created by buzz on 2021/04/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
  }

  func sceneDidDisconnect(_ scene: UIScene) { }

  func sceneDidBecomeActive(_ scene: UIScene) { }

  func sceneWillResignActive(_ scene: UIScene) { }

  func sceneWillEnterForeground(_ scene: UIScene) { }

  func sceneDidEnterBackground(_ scene: UIScene) { }
}

extension SceneDelegate {

  func createTabVC() {
    self.dismissVC()

    if let vc = GeneralHelper.sharedInstance.makeTabBarViewController("Base", "BaseTabBarViewController") as? BaseTabBarViewController {
      window?.rootViewController = vc
      window?.makeKeyAndVisible()
    }
  }

  func dismissVC() {
    if window?.rootViewController?.presentedViewController != nil {
      window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
  }
}
