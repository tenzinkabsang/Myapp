
import Foundation
import Firebase
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI


class AuthManager: NSObject {
    static let shared = AuthManager()
        
    init(withNavigationBar: Bool = false) {
        
        super.init()
        
        let authUI = FUIAuth.defaultAuthUI()
        
        authUI?.providers = getSupportedProviders()
    }
    
    var authView: UIViewController {
        let authUI = FUIAuth.defaultAuthUI()
        return (authUI?.authViewController())! as UIViewController
    }
    
    
    private func getSupportedProviders() -> [FUIAuthProvider] {
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
        
        return [emailAuthProvider, googleAuth]
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

