//
//  LogoutViewController.swift
//  HeyDude
//
//  Created by Sean McCalgan on 2018/06/08.
//  Copyright © 2018 Sean McCalgan. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "LoggedIn")
        
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginView")
        self.present(loginView!, animated: true, completion: nil)
        
    }
    
    
}
