//
//  JoinUSTests.swift
//  JoinUSTests
//
//  Created by Bhavesh Patel on 22/10/23.
//

import XCTest

@testable import JoinUS

final class JoinUSTests: XCTestCase {

    var sut : InputViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = InputViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnAppear(){
        XCTAssertEqual(sut.usernName, "")
        XCTAssertEqual(sut.phoneNumber, "")
        XCTAssertEqual(sut.gender,"")
        XCTAssertEqual(sut.unitformsize, "Not Set")
        XCTAssertFalse(sut.needUnifrom)
        XCTAssertFalse(sut.isReadytoSubmit)
    }
    
    func testValidatedNameEmpty() throws{
        let expectation = expectation(description: "Name is empty")
        
        XCTAssertTrue((sut.usernName == ""))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNameShort() throws{

        sut.usernName = "j"
        let expectation = expectation(description: "Name is too short")
        
        XCTAssertTrue(FieldValidator().validateMinLength(input: sut.usernName))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNameLong() throws{
        sut.usernName = "jss dsg sdfg sdf gsdf gsd fgsd fg sdg sdg sdfg dsf gdsf gds fgds fg dsfg dsfg dfs gdf gdsf gds fgdf"
        let expectation = expectation(description: "Name is too long")
        
        XCTAssertTrue(FieldValidator().validateMaxLength(input: sut.usernName))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNameAlphabetsOnly() throws{
        sut.usernName = "324729387232342 #%^#$"
        let expectation = expectation(description: "Only alphabets are allowed")
        
        XCTAssertFalse(FieldValidator().validateOnlyAlphabetscharacters(input: sut.usernName ))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNameValidName() throws{
        sut.usernName = "Bhavesh"
        let expectation = expectation(description: "Name is valid")
    
        XCTAssertTrue(FieldValidator().validateNameField(input: sut.usernName))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNameInValidName() throws{
       
        sut.usernName = "Bhavesh Patel"
        let expectation = expectation(description: "Name is Invalid")
    
        XCTAssertFalse(FieldValidator().validateNameField(input: sut.usernName))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    

    func testValidatedPhoneEmpty() throws{
        let expectation = expectation(description: "Phone is empty" )
        
        XCTAssertTrue(sut.phoneNumber == "")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedPhoneValid() throws{
        sut.phoneNumber = "+12345678900"
        let expectation = expectation(description: "Phone number is valid")
    
        XCTAssertTrue(FieldValidator().validatePhoneNumber(input: sut.phoneNumber))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedPhoneInValid() throws{
        sut.phoneNumber = "+12345678"
        let expectation = expectation(description: "Phone number is invalid")
    
        XCTAssertFalse(FieldValidator().validatePhoneNumber(input: sut.phoneNumber))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedPhoneInValid2() throws{
       
        sut.phoneNumber = "12345678900"
        let expectation = expectation(description: "Phone number is invalid")
    
        XCTAssertFalse(FieldValidator().validatePhoneNumber(input: sut.phoneNumber))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedGenderIsNotSelected() throws{
       
        let expectation = expectation(description: "No gender selected")
        
        XCTAssertEqual(sut.gender,"")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedGenderSelected() throws{
       
        let expectation = expectation(description: "At lease one gender selected")
        sut.gender = "Male"
        XCTAssertTrue(sut.gender != "")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }

    func testValidatedGenderMaleSelection() throws{
       
        let expectation = expectation(description: "Male gender selected")
        sut.gender = "Male"
        XCTAssertEqual(sut.gender,"Male")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }

    
    func testValidatedGenderFemaleSelection() throws{
  
        let expectation = expectation(description: "Female gender selected")
        
        sut.gender = "Female"
        XCTAssertEqual(sut.gender,"Female")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedGenderOtherSelection() throws{
  
        let expectation = expectation(description: "Other gender selected")
        
        sut.gender = "Other"
        XCTAssertEqual(sut.gender,"Other")

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
   


    func testValidatedNeedUniformOff() throws{
       
        let expectation = expectation(description: "Need uniform switch is off")
        
        XCTAssertTrue((sut.needUnifrom == false))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    
    func testValidatedNeedUniformOn() throws{
       
        let expectation = expectation(description: "Need uniform switch is On")
        sut.needUnifrom = true
        XCTAssertTrue((sut.needUnifrom == true))

        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
    


    func testvalidatedAlertActionChangingValues() throws {
       
        let expectation = expectation(description: "Swipe up and select S")
        
        //Change S to any other size if needed
        sut.unitformsize = "S"
        XCTAssertEqual(sut.unitformsize, "S")
        expectation.fulfill()
        
        wait(for:[expectation],timeout: 0.5)
    }
}
