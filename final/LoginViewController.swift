//
//  ViewController.swift
//  final
//
//  Created by Ernoul on 15/02/2018.
//  Copyright © 2018 Ernoul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, SignUpViewDelegate, SignInViewDelegate {
    
    @IBOutlet weak var signUp: SignUp!
    @IBOutlet weak var signIn: SignIn!
    
    var aUser: StaticUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp.delegate = self
        signIn.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLogin() {
        signIn.isHidden = false
        signUp.isHidden = true
    }
    
    func rgstr() {
        signUp.isHidden = false
        signIn.isHidden = true
    }
    
    func login() {
        if (aUser?.email == signIn.emailTxt.text) && (aUser?.password == signIn.pwTxt.text) {
            signIn.errorMsg.textColor = UIColor.red
            signIn.errorMsg.text = "Logged in"
        } else {
            signIn.errorMsg.textColor = UIColor.red
            signIn.errorMsg.text = "Wrong tokens"
        }
    }
    
    func rgstrAct() {
        //Check if pw match + register
        signIn.errorMsg.text = ""
        aUser = StaticUser()
        if signUp.pwTxt.text == signUp.pwCnfrmTxt.text {
            if let newUserEmail = signUp.emailTxt.text {
                aUser?.email = newUserEmail
                print(newUserEmail)
            }
            if let newUserPw = signUp.pwTxt.text {
                aUser?.password = newUserPw
                print(newUserPw)
            }
            signUp.errorMsg.text = "You have been registered"
            goToLogin()
        } else {
            signUp.errorMsg.text = "Passwords do no match"
        }
    }
    
    

}

