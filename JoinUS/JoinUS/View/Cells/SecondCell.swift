//
//  EmployeeCell.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 20/10/23.
//

import UIKit

protocol secondCellDelegate: AnyObject {
    func isForm2(completed: Bool)
}

//Cell used in Join Us
class SecondCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //local variables and delegates
    weak var formDelegate: secondCellDelegate?
    weak var delegate: CellDelegate?
    var selfController: UIViewController?
    var indexPath : IndexPath?
    
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    var lblUniform: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .black
        label.text = "Need uniform"
        return label
    }()
    
    var switchUniform: UISwitch = {
        let switches = UISwitch()
        switches.isOn = false
        switches.accessibilityIdentifier = "needUniform"
        return switches
    }()
    
    var lblSize: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .black
        label.text = "Uniform Size"
        return label
    }()
    
    let bgView = UIView()
    
    var lblSizeValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .semibold)
        label.textColor = .darkGray.withAlphaComponent(0.7)
        label.text = "Not Set"
        label.accessibilityIdentifier = "UniformSize"
        label.textAlignment = .right
        return label
    }()
    
    var iconImageView: UIImageView = {
      let iv = UIImageView()
      iv.contentMode = .scaleAspectFit
      return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.accessibilityIdentifier = "sizePicker"
    }
    
    func configureUI(){
        for i in contentView.subviews{
            i.removeFromSuperview()
        }
    
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.white
        contentView.addSubview(bgView)
        
        let mainPadding = 20.0
       
        //set second cell, which has uniform
        //Uniform
        contentView.addSubview(lblUniform)
        lblUniform.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 20.0, paddingLeft: mainPadding+20)
        
        contentView.addSubview(switchUniform)
        switchUniform.anchor(top: self.topAnchor, left: lblUniform.rightAnchor, right: self.rightAnchor, paddingTop: 20.0, paddingLeft: 8,paddingRight: mainPadding+20)
        switchUniform.centerY(inView: lblUniform)
        switchUniform.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    
        if switchUniform.isOn {
            contentView.addSubview(separator)
            separator.anchor(top: switchUniform.bottomAnchor,left: lblUniform.leftAnchor, right: self.rightAnchor, paddingTop: 15, paddingRight: 20, height: 0.5)
            
            contentView.addSubview(lblSize)
            lblSize.anchor(top: switchUniform.bottomAnchor, left: self.leftAnchor, paddingTop: 40.0, paddingLeft: mainPadding+20)
            
            contentView.addSubview(lblSizeValue)
            lblSizeValue.anchor(top: switchUniform.bottomAnchor, right: self.rightAnchor , paddingTop: 40.0, paddingRight: mainPadding+30, width: 70)
            
            contentView.addSubview(iconImageView)
            iconImageView.anchor(top: switchUniform.bottomAnchor, right: self.rightAnchor , paddingTop: 40.0, paddingRight: mainPadding+10)
            let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
            iconImageView.image = UIImage(systemName: "chevron.right",withConfiguration: boldConfiguration)!
            iconImageView.tintColor = .darkGray.withAlphaComponent(0.7)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            lblSizeValue.isUserInteractionEnabled = true
            lblSizeValue.addGestureRecognizer(tapGesture)
            //background
            bgView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: lblSizeValue.bottomAnchor,right: contentView.rightAnchor, paddingLeft: mainPadding,paddingBottom: -20, paddingRight: mainPadding)
            contentView.anchor(top: self.topAnchor,left: self.leftAnchor,bottom: self.bottomAnchor,right: self.rightAnchor)
        }else{
            //background
            bgView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: switchUniform.bottomAnchor,right: contentView.rightAnchor, paddingLeft: mainPadding,paddingBottom: -20, paddingRight: mainPadding)
        }
    }
    
    //cehck to enable submit button
    func checkIfValuesArefilled(){
        if switchUniform.isOn && lblSizeValue.text != "Not Set" {
            self.formDelegate?.isForm2(completed: true)
        }else{
            self.formDelegate?.isForm2(completed: false)
        }
    }
    
    //show picker
    @objc func viewTapped() {
        self.showPickerOnTap()
    }
    
    func showPickerOnTap() {
        let alertController = MyBetterAlertController(title: "Select an option", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { UIAlertAction in
            self.checkIfValuesArefilled()
            alertController.dismiss(animated: true)
        }))

        alertController.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 8),
            pickerView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -60)
        ])
        
        selfController!.present(alertController, animated: true)
    }
    
    //Handle UIChange to show size
    @objc func switchValueChanged() {
        self.checkIfValuesArefilled()
        self.configureUI()
        delegate?.cellChanged(indexPath: self.indexPath!)
    }
    
    //change the cell height as per the content
    override func layoutSubviews() {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.bgView.frame.height)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    let sizes = ["Not Set","XS", "S", "M", "L", "XL", "XXL"]
    
    // UIPickerViewDataSource methods
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1 // Number of components (columns)
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return sizes.count // Number of rows in the component
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return sizes[row] // Content for each row
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = sizes[row]
        lblSizeValue.text = selectedOption
        checkIfValuesArefilled()
        // You can use the selected option as needed
    }
    
    let pickerView = UIPickerView()
    
}
