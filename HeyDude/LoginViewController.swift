//
//  ViewController.swift
//  HeyDude
//
//  Created by Sean McCalgan on 2018/06/07.
//  Copyright © 2018 Sean McCalgan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEntry: UITextField!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    fileprivate var rootViewController: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        userView.layer.cornerRadius = 5
        passwordView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        guard let userEntered = userEntry.text.nilIfEmpty else {
            shakeView(viewToShake: userView)
            return
        }
        
        guard let passEntered = userPass.text.nilIfEmpty else {
            shakeView(viewToShake: passwordView)
            return
        }
        
        if UserDefaults.standard.object(forKey: "Username") != nil {
            let userStored = UserDefaults.standard.object(forKey: "Username") as! String
            let passStored = UserDefaults.standard.object(forKey: "Password") as! String
            
            print("User defaults: \(userStored) + \(passStored)")
            print("User entries: \(userEntered) + \(passEntered)")
            
            if userEntered == userStored {
                if passEntered == passStored {
                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                } else {
                    showLoginAlert(message: "Password Incorrect")
                    return
                }
            } else {
                showLoginAlert(message: "Username Incorrect")
                return
            }
            
        } else {
            UserDefaults.standard.set(userEntered, forKey: "Username")
            UserDefaults.standard.set(passEntered, forKey: "Password")
            UserDefaults.standard.set(true, forKey: "LoggedIn")
        }
        
        showMainViewController()
        
    }
    
    func showLoginAlert(message: String) {
        let alert = UIAlertController(title: "HeyDude Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func shakeView(viewToShake: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x - 10, y: viewToShake.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x + 10, y: viewToShake.center.y))
        
        viewToShake.layer.add(animation, forKey: "position")
    }
    
    func showMainViewController() {
        guard !(rootViewController is UITabBarController) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav =  storyboard.instantiateViewController(withIdentifier: "NavigationMain") as! UITabBarController
        nav.willMove(toParentViewController: self)
        addChildViewController(nav)
        
        if let rootViewController = self.rootViewController {
            self.rootViewController = nav
            rootViewController.willMove(toParentViewController: nil)
            
            transition(from: rootViewController, to: nav, duration: 0.55, options: [.transitionCrossDissolve, .curveEaseOut], animations: { () -> Void in
                
            }, completion: { _ in
                nav.didMove(toParentViewController: self)
                rootViewController.removeFromParentViewController()
                rootViewController.didMove(toParentViewController: nil)
            })
        } else {
            rootViewController = nav
            view.addSubview(nav.view)
            nav.didMove(toParentViewController: self)
        }
    }


}

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

