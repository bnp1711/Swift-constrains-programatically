//
//  EmployeeCell.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 20/10/23.
//

import UIKit
    

//Cell used in Join Us
class ThirdCell: UITableViewCell {
    
    //design controls
    var btnSubmit: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17,weight: .semibold)
        button.setTitle("Submit", for: .normal)
        button.accessibilityIdentifier = "btnSubmit"
        button.backgroundColor = UIColor.systemGray
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    var delegate : thirdCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        let bgView = UIView()
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.white
        contentView.addSubview(bgView)
        delegate = self
        let mainPadding = 20.0
        addSubview(btnSubmit)
        btnSubmit.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,right: contentView.rightAnchor, paddingTop: 15, paddingLeft: mainPadding+20, paddingRight: mainPadding+20, height: 50)
        
        //background
        bgView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: btnSubmit.bottomAnchor,right: contentView.rightAnchor, paddingLeft: mainPadding,paddingBottom: -15, paddingRight: mainPadding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//delegate implementation to enable/disable submit button
extension ThirdCell: thirdCellDelegate {
    func submitForm(isAllerrorFixed: Bool) {
        if isAllerrorFixed {
            self.btnSubmit.isEnabled = true
            self.btnSubmit.backgroundColor = UIColor.systemGreen
        }else{
            self.btnSubmit.isEnabled = false
            self.btnSubmit.backgroundColor = UIColor.systemGray
        }
    }
}
    
