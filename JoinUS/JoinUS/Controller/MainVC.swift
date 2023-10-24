//
//  ViewController.swift
//  JoinUS
//
//  Created by Bhavesh Patel on 20/10/23.
//

import UIKit

//cell identified contstant
private let reuseIdentifier1 = "FirstCell"
private let reuseIdentifier2 = "SecondCell"
private let reuseIdentifier3 = "ThirdTCell"

//procol to update cell heihgt in tableview if cell design in changed
protocol CellDelegate: AnyObject {
    func cellChanged(indexPath: IndexPath)
}

protocol thirdCellDelegate: AnyObject {
    func submitForm(isAllerrorFixed: Bool)
}

class MainVC: UITableViewController{

    var isFirstCellCompleted = false
    var isSecondCellCompleted = false
    
    private var employeeViewModel : EmployeesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureUI()
        self.configureNavigationBar(withTitle: "Join Us")
    }

    //set the design for the screen
    func configureUI(){
        // Set background color for the screen
        tableView.backgroundColor = UIColor.mylightGray
        tableView.keyboardDismissMode = .onDrag
        
        // regiter cell
        tableView.register(FirstCell.self, forCellReuseIdentifier: reuseIdentifier1)
        tableView.register(SecondCell.self, forCellReuseIdentifier: reuseIdentifier2)
        tableView.register(ThirdCell.self, forCellReuseIdentifier: reuseIdentifier3)
        
        // Seperator
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        // Set height
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.allowsSelection = false
    }

    private func configureNavigationBar(withTitle title: String) {
        // Create an attributed string for the title with the desired text color
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // Change this to the desired color
        ]
        
        // Enable large titles for the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true

        // Apply the title text color to the navigation bar
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes

        // Set the navigation bar title
        navigationItem.title = title
        
        self.configureLargeNavigationTitle()
    }

    private func configureLargeNavigationTitle() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .mylightGray
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    func checkIfAllformCompleted(){
        if let thirdCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ThirdCell {
            if isFirstCellCompleted && isSecondCellCompleted {
                thirdCell.delegate?.submitForm(isAllerrorFixed: true)
            }else{
                thirdCell.delegate?.submitForm(isAllerrorFixed: false)
            }
        }
    }
}


extension MainVC {
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    /// Display a `EmployeeCell`
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as? FirstCell else { return UITableViewCell() }
            cell.contentView.frame = CGRect(x: cell.contentView.frame.origin.x, y: cell.contentView.frame.origin.y, width: tableView.frame.width, height: cell.contentView.frame.height)
            cell.delegate = self
            cell.formDelegate = self
            cell.configureUI()
            cell.indexPath = indexPath
            return cell
        }else
        if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as? SecondCell else { return UITableViewCell() }
            cell.delegate = self
            cell.formDelegate = self
            cell.selfController = self
            cell.configureUI()
            cell.indexPath = indexPath
            return cell
        }else
        if indexPath.row == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as? ThirdCell else { return UITableViewCell() }
            cell.btnSubmit.addTarget(self,action: #selector(onClick_btnSubmit(sender:)), for: .touchUpInside)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    @objc func onClick_btnSubmit(sender: UIButton){
        //Everythig is working fetched the entered details here
        if let firstCell =  tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FirstCell, let secondCell =  tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SecondCell{
            
            self.employeeViewModel =  EmployeesViewModel()
            let genders = ["Male", "Female", "Other"]
            
            //model is passed to api calling function
            self.employeeViewModel.setEmpModel(model: Employees(name: firstCell.txtName.text!, phone: firstCell.txtPhone.text!, gender: genders[firstCell.segmentGender.selectedSegmentIndex], size: secondCell.lblSizeValue.text!))
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let cell = tableView.cellForRow(at: indexPath) as? FirstCell {
                return cell.bgView.frame.height+30
            }else{
                return 210
            }
        }else if indexPath.row == 1 {
            if let cell = tableView.cellForRow(at: indexPath) as? SecondCell {
                return cell.bgView.frame.height+30
            }else{
                return 100
            }
        }else if indexPath.row == 2 {
            return 70
        }else{
            return UITableView.automaticDimension
        }
    }
}

extension MainVC: CellDelegate {
    func cellChanged(indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}
extension MainVC: secondCellDelegate {
    func isForm2(completed: Bool) {
        isSecondCellCompleted = completed
        self.checkIfAllformCompleted()
    }
}
extension MainVC: firstCellDelegate {
    func isForm(completed: Bool) {
        isFirstCellCompleted = completed
        self.checkIfAllformCompleted()
    }
}
