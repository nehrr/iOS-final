//
//  SignIn.swift
//  final
//
//  Created by Ernoul on 15/02/2018.
//  Copyright © 2018 Ernoul. All rights reserved.
//

import UIKit

class SignIn: UIView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var pwLbl: UILabel!
    @IBOutlet weak var pwTxt: UITextField!
    
    @IBOutlet weak var notRgstrdYetLbl: UILabel!
    @IBOutlet weak var rgstrBtn: UIButton!
    
    @IBAction func loginBtn(_ sender: Any) {
        delegate?.login()
    }
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func rgstrBtn(_ sender: Any) {
        delegate?.rgstr()
    }
    
    @IBOutlet weak var errorMsg: UILabel!
    var delegate: SignInViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SignIn", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
