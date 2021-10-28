//
//  CoreDataStackTest.swift
//  testWeatherAppTests
//
//  Created by Георгий on 28.10.2021.
//

import XCTest
@testable import testWeatherApp
import CoreData

class CoreDataStackTest: XCTestCase {

    let coreDataManager = ViewController.coreDataManager
    
    func testCoreDataStackInitialization() throws {
        let coreDataStack = coreDataManager.storeContainer
        XCTAssertNotNil(coreDataStack)
    }
    
    func testSavingAndDeletingCity() throws {
        let nameFirst: String = "Moscow"
        let nameSecond: String = "London"
        
        let objectFirst: () = coreDataManager.createObject(for: CityEntity.self) { city in
            city.title = nameFirst
        }
        XCTAssertNotNil(objectFirst)
        
        let objectSecond: () = coreDataManager.createObject(for: CityEntity.self) { city in
            city.title = nameSecond
        }
        XCTAssertNotNil(objectSecond)
        
        let results = coreDataManager.fetch(with: CityEntity.fetchRequest())
        XCTAssertEqual(results.count, 2)
        
        let city = results[0]
        let numberOfItems = results.count
        
        coreDataManager.deleteObject(city: city)
        
        XCTAssertEqual(coreDataManager.fetch(with: CityEntity.fetchRequest()).count, numberOfItems - 1)
    }
    
    
}
