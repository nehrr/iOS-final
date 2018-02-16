//
//  SignUp.swift
//  final
//
//  Created by Ernoul on 15/02/2018.
//  Copyright © 2018 Ernoul. All rights reserved.
//

import UIKit

class SignUp: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    @IBOutlet weak var pwLbl: UILabel!
    @IBOutlet weak var pwTxt: UITextField!
    
    @IBOutlet weak var pwCnfrmLbl: UILabel!
    @IBOutlet weak var pwCnfrmTxt: UITextField!
    
    @IBOutlet weak var goToLoginBtn: UIButton!
    @IBOutlet weak var alrdyRgstrdLbl: UILabel!
    @IBAction func signUpBtn(_ sender: Any) {
        delegate?.rgstrAct()
    }
    
    @IBAction func goToLoginBtn(_ sender: Any) {
        delegate?.goToLogin()
    }
    @IBOutlet weak var signUpBtn: UIButton!
    
    var delegate: SignUpViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SignUp", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

}
