//
//  EmployeeCell.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 20/10/23.
//

import UIKit

protocol firstCellDelegate: AnyObject {
    func isForm(completed: Bool)
}

//Cell used in Join Us
class FirstCell: UITableViewCell {
    
    //local delegates and variables
    weak var formDelegate: firstCellDelegate?
    weak var delegate: CellDelegate?
    var indexPath : IndexPath?
    
    //design controls
    var lblName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .black
        label.text = "Name"
        return label
    }()
    
    var txtName: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        textField.textColor = .black
        textField.accessibilityIdentifier = "Name"
        textField.attributedPlaceholder = NSAttributedString(string: "your name", attributes: [
           .foregroundColor: UIColor.lightGray,
           .font: textField.font!
        ])
        
        return textField
    }()
    
    var lblPhone: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .black
        label.text = "Phone"
        return label
    }()
    
    var txtPhone: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        textField.textColor = .black
        textField.accessibilityIdentifier = "Phone"
        textField.attributedPlaceholder = NSAttributedString(string: "your phone number", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: textField.font!
        ])
        return textField
    }()
    
    var lblGender: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .black
        label.text = "Gender"
        return label
    }()
    
    var segmentGender: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Male", "Female", "Other"])
        segment.selectedSegmentTintColor = UIColor.white
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        segment.accessibilityIdentifier = "Gender"
        // Apply the text attributes to the segmented control
        segment.setTitleTextAttributes(textAttributes, for: .normal)
        return segment
    }()
    
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    var separator2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    var separator3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    //error handling
    var isNameInputError = false
    var nameErrorMsg = ""
    
    var isPhoneInputError = false
    var phoneErrorMsg = ""
    
    var nameErrorImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFit
      return iv
    }()
    
    var lblNameError: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .regular)
        label.textColor = .systemRed
        label.text = ""
        return label
    }()
    
    var phoneErrorImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFit
      return iv
    }()
    
    
    var lblPhoneError: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .regular)
        label.textColor = .systemRed
        label.text = ""
        return label
    }()
    
    var currentSelected = 0
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        txtName.delegate = self
        txtPhone.delegate = self
    }
    
    var bgView :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    func configureUI(){
        //removing previous contraits
        for i in contentView.subviews{
            i.removeallContrains()
        }
        
        if bgView.superview == nil {
           contentView.addSubview(bgView)
        }
        
        let mainPadding = 20.0
        
        // Set design for the first cell, cointaining name, gender, phone
        //Name
        if lblName.superview == nil {
            contentView.addSubview(lblName)
        }
        lblName.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20.0, paddingLeft: mainPadding+20, width: 60,height: 20)
        lblName.layoutIfNeeded()
        
        if txtName.superview == nil {
            contentView.addSubview(txtName)
        }
        txtName.anchor(top: self.topAnchor, left: lblName.rightAnchor, right: self.rightAnchor, paddingTop: 20.0, paddingLeft: 8,paddingRight: 20,height: 20)
        txtName.centerY(inView: lblName)
        txtName.layoutIfNeeded()
        //Error
       
        nameErrorImageView.removeFromSuperview()
        lblNameError.removeFromSuperview()
        if self.isNameInputError {
            contentView.addSubview(nameErrorImageView)
            nameErrorImageView.anchor(top: lblName.bottomAnchor, left: lblName.leftAnchor,width: 20, height: 50)
            let boldConfiguration = UIImage.SymbolConfiguration(weight: .regular)
            nameErrorImageView.image = UIImage(systemName: "exclamationmark.triangle.fill",withConfiguration: boldConfiguration)!
            nameErrorImageView.tintColor = .systemRed
           
            contentView.addSubview(lblNameError)
            lblNameError.anchor(top: lblName.bottomAnchor, left: nameErrorImageView.rightAnchor, right: self.rightAnchor,paddingLeft: 8, paddingBottom: 20.0, paddingRight: mainPadding+20, height: 50)
            lblNameError.centerY(inView: nameErrorImageView)
            lblNameError.text = self.nameErrorMsg
            lblNameError.numberOfLines = 2
        }
        //separator
        separator.removeFromSuperview()
        contentView.addSubview(separator)
        if self.isNameInputError {
            separator.anchor(top: lblNameError.bottomAnchor, left: lblName.leftAnchor, right: self.rightAnchor,paddingTop: 15, paddingRight: 20, height: 0.5)
        }else{
            separator.anchor(top: txtName.bottomAnchor, left: lblName.leftAnchor, right: self.rightAnchor,paddingTop: 15, paddingRight: 20, height: 0.5)
        }
        
        //Phone
        if lblPhone.superview == nil {
            contentView.addSubview(lblPhone)
        }
        lblPhone.anchor(top: separator.bottomAnchor, left: self.leftAnchor, paddingTop: 20.0, paddingLeft: mainPadding+20,width: 60,height: 20)
        
        if txtPhone.superview == nil {
            contentView.addSubview(txtPhone)
        }
        txtPhone.anchor(top: separator.bottomAnchor, left: lblPhone.rightAnchor, right: self.rightAnchor, paddingTop: 20.0, paddingLeft: 10,paddingRight: 20)
        txtPhone.centerY(inView: lblPhone)
        txtPhone.keyboardType = .phonePad
        
        //error
        phoneErrorImageView.removeFromSuperview()
        lblPhoneError.removeFromSuperview()
        if self.isPhoneInputError {
            contentView.addSubview(phoneErrorImageView)
            phoneErrorImageView.anchor(top: lblPhone.bottomAnchor, left: lblPhone.leftAnchor,width: 20, height: 30)
            let boldConfiguration = UIImage.SymbolConfiguration(weight: .regular)
            phoneErrorImageView.image = UIImage(systemName: "exclamationmark.triangle.fill",withConfiguration: boldConfiguration)!
            phoneErrorImageView.tintColor = .systemRed
           
            contentView.addSubview(lblPhoneError)
            lblPhoneError.anchor(top: lblPhone.bottomAnchor, left: phoneErrorImageView.rightAnchor, right: self.rightAnchor,paddingLeft: 8, paddingBottom: 20.0, paddingRight: mainPadding+20, height: 30)
            lblPhoneError.centerY(inView: phoneErrorImageView)
            lblPhoneError.text = self.phoneErrorMsg
            lblPhoneError.numberOfLines = 2
        }
        
        //separator
        separator2.removeFromSuperview()
        contentView.addSubview(separator2)
        if self.isPhoneInputError {
            separator2.anchor(top: lblPhoneError.bottomAnchor,left: lblPhone.leftAnchor, right: self.rightAnchor, paddingTop: 15, paddingRight: 20, height: 0.5)
        }else{
            separator2.anchor(top: txtPhone.bottomAnchor,left: lblPhone.leftAnchor, right: self.rightAnchor, paddingTop: 15, paddingRight: 20, height: 0.5)
        }
        
        //Gender
        if lblGender.superview == nil {
            contentView.addSubview(lblGender)
        }
        lblGender.anchor(top: separator2.bottomAnchor, left: self.leftAnchor, paddingTop: 20.0, paddingLeft: mainPadding+20,width: 60,height: 20)
        
        if segmentGender.superview == nil {
            contentView.addSubview(segmentGender)
        }
        segmentGender.anchor(top: separator2.bottomAnchor, left: lblGender.rightAnchor, right: self.rightAnchor, paddingTop: 15, paddingLeft: 8, paddingRight: 30)
        segmentGender.centerY(inView: lblGender)
        segmentGender.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)

        
        //white background
        bgView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: segmentGender.bottomAnchor,right: contentView.rightAnchor, paddingLeft: mainPadding,paddingBottom: -20, paddingRight: mainPadding)
        contentView.layoutIfNeeded()
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        self.checkIfValuesArefilled()
    }

    //handling cell design changes
    @objc func cellChanged() {
        self.configureUI()
        delegate?.cellChanged(indexPath: self.indexPath!)
    }
    
    //change the cell height as per the content
    override func layoutSubviews() {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.bgView.frame.height)
        contentView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.bgView.frame.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //checking values to enable submit button
    func checkIfValuesArefilled(){
        if isNameInputError == false && txtName.text != "" && isPhoneInputError == false && txtPhone.text != "" && segmentGender.selectedSegmentIndex != -1{
            self.formDelegate?.isForm(completed: true)
        }else{
            self.formDelegate?.isForm(completed: false)
        }
    }
}

extension FirstCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine the current text with the replacement string
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if textField == txtName{
            self.nameErrorMsg = ""
            self.isNameInputError = false
            
            if updatedText == ""{
                textField.text = ""
                self.cellChanged()
                self.checkIfValuesArefilled()
                return true
            }
            
            // Validate the updated text
            if FieldValidator().validateNameField(input: updatedText) {
                // The updated text is valid, allow the change
                self.isNameInputError = false
                self.nameErrorMsg = ""
                self.cellChanged()
                self.checkIfValuesArefilled()
                return true
            } else {
                //checking the error and setting message accordingly
                self.isNameInputError = true
                if FieldValidator().validateMaxLength(input: updatedText){
                    self.nameErrorMsg = "Name shall be less than 35 characters"
                }else if FieldValidator().validateMinLength(input: updatedText) {
                    self.nameErrorMsg = "Name shall be more than 5 characters"
                }else if !FieldValidator().validateOnlyAlphabetscharacters(input: updatedText){
                    self.nameErrorMsg = "Only alphabetic characters are accepted"
                }
                self.checkIfValuesArefilled()
                self.cellChanged()
                return true
            }
        }else if textField == txtPhone {
            self.phoneErrorMsg = ""
            self.isPhoneInputError = false
            
            if updatedText == ""{
                textField.text = ""
                self.cellChanged()
                self.checkIfValuesArefilled()
                return true
            }
            
            // Validate the updated text
            if FieldValidator().validatePhoneNumber(input: updatedText) {
                // The updated text is valid, allow the change
                self.isPhoneInputError = false
                self.phoneErrorMsg = ""
                self.checkIfValuesArefilled()
                self.cellChanged()
                return true
            } else {
                //checking the error and setting message accordingly
                self.isPhoneInputError = true
                self.phoneErrorMsg = "Please input correct phone number"
                self.checkIfValuesArefilled()
                self.cellChanged()
                return true
            }
        }else{
            return true
        }
    }
}
