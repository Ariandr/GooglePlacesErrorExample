//
//  AppDelegate.swift
//  PlacesErrorExample
//

import UIKit
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var googleAPIKey: String {
        fatalError("return provided API Key here")
        return ""
    }

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        setupGooglePlaces()
        
        return true
    }
    
    private func setupGooglePlaces() {
        GMSPlacesClient.provideAPIKey(AppDelegate.googleAPIKey)
    }
}

