import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var datePickerViewController: DatePickerViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let vc = DatePickerViewController()
        
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()

        return true
    }

}

