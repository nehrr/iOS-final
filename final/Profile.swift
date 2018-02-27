//
//  Profile.swift
//  final
//
//  Created by Ernoul on 16/02/2018.
//  Copyright © 2018 Ernoul. All rights reserved.
//

import UIKit

class Profile: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileTitle: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var pwLbl: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func backBtn(_ sender: Any) {
        delegate?.deleteAcc()
    }
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var chngPwLbl: UILabel!
    @IBOutlet weak var chngPwTxt: UITextField!

    @IBAction func logBtn(_ sender: Any) {
        delegate?.returnLogin()
    }
    
    @IBAction func chngPwBtn(_ sender: Any) {
        delegate?.chngPw()
    }

    @IBOutlet weak var chngPwCnfmLbl: UILabel!
    @IBOutlet weak var chngPwCnfmTxt: UITextField!
    
    @IBOutlet weak var chngEmailLbl: UILabel!
    @IBOutlet weak var chngEmailTxt: UITextField!
    
    @IBAction func chngEmailBtn(_ sender: Any) {
        delegate?.chngEmail()
    }
    
    var delegate: ProfileDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("Profile", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

}
