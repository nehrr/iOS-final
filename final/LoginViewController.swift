    //
    //  ViewController.swift
    //  final
    //
    //  Created by Ernoul on 15/02/2018.
    //  Copyright © 2018 Ernoul. All rights reserved.
    //
    
    import UIKit
    
    //Current version only handles iPhone 8 format
    class LoginViewController: UIViewController, SignUpViewDelegate, SignInViewDelegate, ProfileDelegate {
        
        @IBOutlet weak var signUp: SignUp!
        @IBOutlet weak var signIn: SignIn!
        @IBOutlet weak var profile: Profile!
        
        var aUser: StaticUser?
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            //Init singleton
            aUser = StaticUser()
            
            //Hide profile at start
            profile.isHidden = true
            
            //Instantiate delegates as LoginViewController
            signUp.delegate = self
            signIn.delegate = self
            profile.delegate = self
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
        //Email validation test
        func isValid(_ email: String) -> Bool {
            //Wtf is this regex though
            let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
            
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
        
        func chngEmail() {
            if profile.chngEmailTxt.text != "" {
                if isValid(profile.chngEmailTxt.text!) == true {
                    if let newEmail = profile.chngEmailTxt.text {
                        aUser?.user?.email = newEmail
                        
                        profile.msgLbl.text = "Your email has been changed"
                        profile.msgLbl.textColor = UIColor.green
                        profile.emailLbl.text = "Your new email is: \(newEmail)"
                        
                        profile.chngEmailTxt.backgroundColor = UIColor.white
                        profile.chngPwTxt.backgroundColor = UIColor.white
                        profile.chngPwCnfmTxt.backgroundColor = UIColor.white
                    }
                } else {
                    profile.chngEmailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    profile.msgLbl.text = "Your new email is not valid"
                    profile.msgLbl.textColor = UIColor.red
                }
            } else {
                profile.chngEmailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                profile.msgLbl.text = "Your new email cannot be empty"
                profile.msgLbl.textColor = UIColor.red
            }
            
        }
        
        func chngPw() {
            if (profile.chngPwTxt.text != "") && (profile.chngPwCnfmTxt.text != ""){
                if profile.chngPwTxt.text!.count > 5 && profile.chngPwCnfmTxt.text!.count > 5 {
                    if profile.chngPwTxt.text == profile.chngPwCnfmTxt.text {
                        if let newPw = profile.chngPwTxt.text {
                            aUser?.user?.password = newPw
                            
                            profile.msgLbl.text = "Your password has been changed"
                            profile.msgLbl.textColor = UIColor.green
                            profile.pwLbl.text = "Your new password is: \(newPw)"
                            
                            profile.chngEmailTxt.backgroundColor = UIColor.white
                            profile.chngPwTxt.backgroundColor = UIColor.white
                            profile.chngPwCnfmTxt.backgroundColor = UIColor.white
                        }
                    } else {
                        profile.msgLbl.text = "Your new passwords do not match"
                        profile.msgLbl.textColor = UIColor.red
                        profile.chngPwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                        profile.chngPwCnfmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    }
                } else {
                    profile.msgLbl.textColor = UIColor.red
                    profile.msgLbl.text = "Your new password is too short!"
                    profile.chngPwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    profile.chngPwCnfmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                }
            } else {
                profile.msgLbl.textColor = UIColor.red
                profile.msgLbl.text = "Your new password cannot be empty!"
                profile.chngPwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                profile.chngPwCnfmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
            }
        }
        
        func deleteAcc() {
            signIn.errorMsg.text = "You have deleted your account"
            signIn.errorMsg.textColor = UIColor.red
            
            signUp.errorMsg.text = ""
            profile.msgLbl.text = ""
            
            signIn.emailTxt.backgroundColor = UIColor.white
            signIn.pwTxt.backgroundColor = UIColor.white
            
            //Delete User instance)
            aUser?.user = nil
            
            signIn.isHidden = false
            signUp.isHidden = true
            profile.isHidden = true
        }
        
        func goToLogin() {
            signIn.emailTxt.backgroundColor = UIColor.white
            signIn.pwTxt.backgroundColor = UIColor.white
            
            signIn.isHidden = false
            signUp.isHidden = true
        }
        
        func rgstr() {
            //Reset msg to avoid it showing 'you have been registered' again
            //if you go back to the login page after going to the register one
            signIn.errorMsg.text = ""
            
            signUp.isHidden = false
            signIn.isHidden = true
        }
        
        func login() {
            
            //Empty errorMsg just in case
            signIn.errorMsg.text = ""
            
            print("email : \(aUser?.user?.email) pw : \(aUser?.user?.password)")
            
            //Reset fields background to white
            signIn.emailTxt.backgroundColor = UIColor.white
            signIn.pwTxt.backgroundColor = UIColor.white
            
            if signIn.emailTxt.text == "" {
                print("Wrong email")
                signIn.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                
                signIn.errorMsg.textColor = UIColor.red
                signIn.errorMsg.text = "Wrong email"
                return
            }
            
            if signIn.pwTxt.text == "" {
                print("Wrong password")
                signIn.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                
                signIn.errorMsg.textColor = UIColor.red
                signIn.errorMsg.text = "Wrong password"
                return
            }
            
            if let userEmail = aUser?.user?.email, let userPw = aUser?.user?.password {
                if userEmail.isEmpty || userEmail != aUser?.user!.email
                    || userEmail != signIn.emailTxt.text || signIn.emailTxt.text!.isEmpty {
                    print("Wrong email unwrapped")
                    signIn.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    
                    signIn.errorMsg.textColor = UIColor.red
                    signIn.errorMsg.text = "Wrong email"
                    return
                }
                
                if userPw.isEmpty || userPw != aUser?.user!.password
                    || userPw != signIn.pwTxt.text || signIn.pwTxt.text!.isEmpty {
                    print("Wrong password unwrapped")
                    signIn.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    
                    signIn.errorMsg.textColor = UIColor.red
                    signIn.errorMsg.text = "Wrong password"
                    return
                }
                
                if (userEmail == signIn.emailTxt.text) && (userPw == signIn.pwTxt.text) {
                    print("email: \(userEmail) pw: \(userPw)")
                    print("\(userEmail == signIn.emailTxt.text)")
                    print("\(userPw == signIn.pwTxt.text)")
                    signIn.errorMsg.textColor = UIColor.green
                    signIn.errorMsg.text = "Logged in"
                    profile.isHidden = false
                    signIn.isHidden = true
                    
                    profile.msgLbl.textColor = UIColor.blue
                    profile.msgLbl.text = "Welcome back!"
                    
                    profile.emailLbl.text = "Your email is: \(aUser!.user!.email)"
                    profile.pwLbl.text = "Your password is: \(aUser!.user!.password)"
                }
                
            }
            
        }
        
        
        //        func login() {
        //            //Empty errorMsg just in case
        //            signIn.errorMsg.text = ""
        //
        //            print("email : \(aUser?.user?.email) pw : \(aUser?.user?.password)")
        //
        //            //Reset fields background to white
        //            signIn.emailTxt.backgroundColor = UIColor.white
        //            signIn.pwTxt.backgroundColor = UIColor.white
        //
        //            if signIn.emailTxt.text != "" {
        //                print("non empty email")
        //                if let userEmail = aUser?.user?.email, let userPw = aUser?.user?.password {
        //                    print("pre unwrapping")
        //                    if userEmail != "" {
        //                        print("in unwrapped email loop \(userEmail)")
        //
        //                        //                    if aUser?.user!.email == signIn.emailTxt.text {
        //
        //                        if signIn.pwTxt.text != "" || userPw != signIn.pwTxt.text {
        //                            if userPw != "" {
        //                                print("in unwrapped pw loop \(userPw)")
        //
        //                                if aUser?.user!.email == signIn.emailTxt.text {
        //                                    print("in email ok loop")
        //                                    if aUser?.user!.password == signIn.pwTxt.text {
        //                                        print("in pw ok loop")
        //
        //                                        signIn.errorMsg.textColor = UIColor.green
        //                                        signIn.errorMsg.text = "Logged in"
        //                                        profile.isHidden = false
        //                                        signIn.isHidden = true
        //
        //                                        profile.msgLbl.textColor = UIColor.blue
        //                                        profile.msgLbl.text = "Welcome back!"
        //
        //                                        profile.emailLbl.text = "Your email is: \(aUser!.user!.email)"
        //                                        profile.pwLbl.text = "Your password is: \(aUser!.user!.password)"
        //
        //                                    }  else {
        //                                    signIn.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
        //
        //                                    signIn.errorMsg.textColor = UIColor.red
        //                                    signIn.errorMsg.text = "Wrong password"
        //                                    } }
        //                                 } } else {
        //                            signIn.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
        //
        //                            signIn.errorMsg.textColor = UIColor.red
        //                            signIn.errorMsg.text = "Wrong password"
        //                        }
        //                    }  } else {
        //                signIn.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
        //
        //                signIn.errorMsg.textColor = UIColor.red
        //                signIn.errorMsg.text = "Wrong email"
        //                    }
        //            } else {
        //                signIn.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
        //                signIn.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
        //
        //                signIn.errorMsg.textColor = UIColor.red
        //                signIn.errorMsg.text = "Wrong tokens"
        //            }
        //        }
        
        //        func login() {
        //            //Empty errorMsg just in case
        //            signIn.errorMsg.text = ""
        //
        //            print("email : \(aUser?.user?.email) pw : \(aUser?.user?.password)")
        //
        //            //Reset fields background to white
        //            signIn.emailTxt.backgroundColor = UIColor.white
        //            signIn.pwTxt.backgroundColor = UIColor.white
        //
        //            if signIn.emailTxt.text != "" || signIn.pwTxt.text != "" {
        //                if signIn.emailTxt.text != "" {
        //                    if let userEmail = aUser?.user?.email, let userPw = aUser?.user?.password {
        //                        if userEmail != "" {
        //
        //                            if signIn.pwTxt.text != "" {
        //                                if aUser?.user!.email == signIn.emailTxt.text {
        //                                    if userPw != "" {
        //                                        if aUser?.user!.password == signIn.pwTxt.text {
        //                                            signIn.errorMsg.textColor = UIColor.green
        //                                            signIn.errorMsg.text = "Logged in"
        //                                            profile.isHidden = false
        //                                            signIn.isHidden = true
        //
        //                                            profile.msgLbl.textColor = UIColor.blue
        //                                            profile.msgLbl.text = "Welcome back!"
        //
        //                                            profile.emailLbl.text = "Your email is: \(aUser!.user!.email)"
        //                                            profile.pwLbl.text = "Your password is: \(aUser!.user!.password)"
        //                                        }
        //                                    }
        //                                }
        //                            } else {
        //                                signIn.errorMsg.text = "Wrong password"
        //                            }
        //                        }
        //                    }
        //                } else {
        //                    signIn.errorMsg.text = "Wrong email"
        //                }
        //            } else {
        //                signIn.errorMsg.text = "Please fill both fields"
        //            }
        //        }
        
        func rgstrAct() {
            //Empty errorMsg just in case
            signUp.errorMsg.text = ""
            
            //Reset fields background to white
            signUp.emailTxt.backgroundColor = UIColor.white
            signUp.pwCnfrmTxt.backgroundColor = UIColor.white
            signUp.pwTxt.backgroundColor = UIColor.white
            
            //Init var user in Singleton
            aUser?.user = User()
            
            //Check if fields are empty
            if (signUp.pwTxt.text != "") && (signUp.emailTxt.text != "") {
                
                //Check if email is valid
                if isValid(signUp.emailTxt.text!) == true {
                    
                    //Check if pw length is sufficient
                    if (signUp.pwTxt.text!.count > 5) || (signUp.pwCnfrmTxt.text!.count > 5) {
                        
                        //Check if pw match
                        if signUp.pwTxt.text == signUp.pwCnfrmTxt.text {
                            if let newUserEmail = signUp.emailTxt.text {
                                aUser?.user?.email = newUserEmail
                                //print(newUserEmail)
                            }
                            if let newUserPw = signUp.pwTxt.text {
                                aUser?.user?.password = newUserPw
                                //print(newUserPw)
                            }
                            signIn.emailTxt.backgroundColor = UIColor.white
                            signIn.pwTxt.backgroundColor = UIColor.white
                            
                            signUp.emailTxt.backgroundColor = UIColor.white
                            signUp.pwCnfrmTxt.backgroundColor = UIColor.white
                            signUp.pwTxt.backgroundColor = UIColor.white
                            
                            signIn.errorMsg.textColor = UIColor.green
                            signIn.errorMsg.text = "You have been registered"
                            goToLogin()
                        } else {
                            signUp.emailTxt.backgroundColor = UIColor.white
                            
                            signUp.errorMsg.textColor = UIColor.red
                            signUp.errorMsg.text = "Passwords do not match"
                            signUp.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                            signUp.pwCnfrmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                        }
                    } else {
                        signUp.errorMsg.textColor = UIColor.red
                        signUp.errorMsg.text = "Password length is too short"
                        
                        signUp.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                        signUp.pwCnfrmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                    }
                } else {
                    signUp.pwCnfrmTxt.backgroundColor = UIColor.white
                    signUp.pwTxt.backgroundColor = UIColor.white
                    
                    signUp.errorMsg.textColor = UIColor.red
                    signUp.errorMsg.text = "Email is not valid"
                    signUp.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                }
            } else {
                signUp.errorMsg.textColor = UIColor.red
                signUp.errorMsg.text = "Please fill all fields"
                signUp.pwTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                signUp.pwCnfrmTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
                signUp.emailTxt.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.72, alpha:1.0)
            }
        }
    }
    
