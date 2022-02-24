
import Foundation
import Firebase
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI


class AuthManager: NSObject {
    static let shared = AuthManager()
    
    var authViewController: UIViewController {
        return MyAuthViewController(authUI: FUIAuth.defaultAuthUI()!)
    }
    
    init(withNavigationBar: Bool = false) {
        
        super.init()
        
        self.setupProviders()
    }
    
    var authView: UIViewController {
        let authUI = FUIAuth.defaultAuthUI()
        return (authUI?.authViewController())! as UIViewController
    }
    
    private func setupProviders() {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://example.appspot.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setAndroidPackageName("com.firebase.example", installIfNotAvailable: false, minimumVersion: "12")

        let emailAuthProvider = FUIEmailAuth(authAuthUI: FUIAuth.defaultAuthUI()!,
                                    signInMethod: EmailPasswordAuthSignInMethod,
                                    forceSameDevice: false,
                                    allowNewEmailAccounts: true,
                                    actionCodeSetting: actionCodeSettings)
        
        
        
        let googleAuth = FUIGoogleAuth(authUI: FUIAuth.defaultAuthUI()!)
        //let facebookAuth = FUIFacebookAuth(authUI: FUIAuth.defaultAuthUI()!)
        
        let providers: [FUIAuthProvider] = [
            emailAuthProvider,
            googleAuth
        ]
        
        FUIAuth.defaultAuthUI()?.providers = providers
    }
    
}



extension AuthManager {
    // an optional handler closure for error handling
    func signOut(onError handler: ((Error?) -> Void)? = nil) {
        do{
            try FUIAuth.defaultAuthUI()?.signOut()
            if let handler = handler {
                handler(nil)
            }
        } catch(let err) {
            if let handler = handler {
                handler(err)
            }
        }
    }
    
    func isSignedIn() -> Bool {
        if let _ = Firebase.Auth.auth().currentUser {
            return true
        }
        
        return false
    }
    
    func setAuthDelegate(_ delegate: FUIAuthDelegate) {
        FUIAuth.defaultAuthUI()?.delegate = delegate
    }
}

class MyAuthViewController: FUIAuthPickerViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
            let scrollView = view.subviews[0]
            scrollView.backgroundColor = .clear
            let contentView = scrollView.subviews[0]
            contentView.backgroundColor = .clear
            view.backgroundColor = .clear
        }
}
