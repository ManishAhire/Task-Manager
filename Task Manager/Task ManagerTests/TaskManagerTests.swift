//
//  TaskManagerTests.swift
//  Task ManagerTests
//
//  Created by Manish Ahire on 09/03/26.
//

import Foundation

import XCTest
@testable import Task_Manager

final class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUp() {
        super.setUp()
        
        // Clear UserDefaults before each test
        let defaults = UserDefaults.standard
        if let bundleID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleID)
        }
        
        sut = TaskManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddTask() {
        sut.addTask("Test Task")
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertEqual(sut.tasks[0].title, "Test Task")
    }
    
    func testToggleTask() {
        sut.addTask("Test Task")
        let task = sut.tasks[0]
        
        sut.toggleTask(task)
        XCTAssertTrue(sut.tasks[0].isCompleted)
    }
    
    func testDeleteTask() {
        sut.addTask("Task 1")
        sut.addTask("Task 2")
        
        XCTAssertEqual(sut.tasks.count, 2)
        sut.deleteTask(at: IndexSet(integer: 0))
        XCTAssertEqual(sut.tasks.count, 1)
    }
}
