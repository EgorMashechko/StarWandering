
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.string(forKey: "ship_image_game") == nil {
            UserDefaults.standard.set("sentinel", forKey: "ship_image_game")
        }
        if UserDefaults.standard.string(forKey: "ship_image_menu") == nil {
            UserDefaults.standard.set("sentinel_menu", forKey: "ship_image_menu")
        }
        if UserDefaults.standard.object(forKey: "ship_speed") == nil {
            UserDefaults.standard.set(10, forKey: "ship_speed")
        }
        if UserDefaults.standard.object(forKey: "ship_damage") == nil {
            UserDefaults.standard.set(50, forKey: "ship_damage")
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available (iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available (iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

