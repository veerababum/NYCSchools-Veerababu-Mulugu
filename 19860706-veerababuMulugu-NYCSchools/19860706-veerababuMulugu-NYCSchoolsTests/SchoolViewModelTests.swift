//
//  SchoolViewModelTests.swift
//  19860706-veerababuMulugu-NYCSchoolsTests
//
//  Created by Veerababu Mulugu on 12/7/22.
//

import CoreLocation
import XCTest
@testable import _9860706_veerababuMulugu_NYCSchools

final class SchoolViewModelTests: XCTestCase {
    var sut: SchoolViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = SchoolViewModel(school: School.fake)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() throws {
        let model = School(id: "01M448",
                           name: "University Neighborhood High School",
                           phoneNumber: "212-962-4341",
                           email: "KChu@schools.nyc.gov",
                           website: "www.universityneighborhoodhs.org",
                           addresLine: "West St",
                           city: "Rochester",
                           zip: "74657",
                           state: "NY",
                           latitude: "40.71227",
                           longitude: "-73.9841")
        sut = SchoolViewModel(school: model)
        
        XCTAssertEqual(sut.name, "University Neighborhood High School")
        XCTAssertEqual(sut.phoneNumber, "212-962-4341")
        XCTAssertEqual(sut.email, "KChu@schools.nyc.gov")
        XCTAssertEqual(sut.website, "www.universityneighborhoodhs.org")
        XCTAssertEqual(sut.address, "West St, Rochester, NY, 74657")        
        XCTAssertNotNil(sut.coordinate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
