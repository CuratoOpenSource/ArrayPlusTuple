//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest
import Quick
import Nimble
import InjectableLoggers
@testable import ArrayPlusTuple

class ArraySpec: QuickSpec {
    
    override func spec() {
        
        let supportedElementsAmount = 24
        let unsupportedElementsAmount = supportedElementsAmount + 1
        
        describe("Given an array") {
            var sut: [Any]!
            
            context("with 0 elements", {
                beforeEach {
                    sut = []
                }
                
                context("When tuple is called", closure: {
                    var tuple: Any!
                    
                    beforeEach {
                        tuple = sut.tuple
                    }
                    
                    it("Then provided tuple is empty tuple", closure: {
                        XCTAssertNotNil(tuple as? ())
                    })
                })
            })
        }
        
        describe("Given a string array") {
            
            var sut: [String]!
            var tuple: Any!
            
            context("with 1 element", {
                beforeEach {
                    sut = self.stringArray(withSize: 1)
                }

                context("When tuple is called", closure: {
                    beforeEach {
                        tuple = sut.tuple
                    }

                    it("Then tuple contains correct elements", closure: {
                        XCTAssertEqual(tuple as! (String), (self.name(forIndex: 0)))
                    })
                })
            })
            
            (2...supportedElementsAmount).forEach({ (elementCount) in
                context("with \(elementCount) elements", {
                    beforeEach {
                        sut = self.stringArray(withSize: elementCount)
                    }
                    
                    context("When tuple is called", closure: {
                        beforeEach {
                            tuple = sut.tuple
                        }
                        
                        it("Then tuple contains correct elements", closure: {
                            let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                            
                            for (index, element) in tupleElements.enumerated() {
                                XCTAssertEqual(element as! String, self.name(forIndex: index), "expected value \(element) at index \(index) in tuple with size \(elementCount)")
                            }
                        })
                        
                        it("Then tuple has \(elementCount) elements", closure: {
                            let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                            XCTAssertEqual(tupleElements.count, elementCount)
                        })
                    })
                })
            })
            
            context("with unsupported (\(unsupportedElementsAmount)+) amount of elements", {
                var mockLogger: MockLogger!
                
                beforeEach {
                    sut = self.stringArray(withSize: unsupportedElementsAmount + 1)
                    mockLogger = MockLogger()
                    logger.relay = mockLogger
                }
                
                context("When tuple is called", closure: {
                    beforeEach {
                        tuple = sut.tuple
                    }
                    
                    it("Then tuple contains correct elements", closure: {
                        let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                        for (index, element) in tupleElements.enumerated() {
                            XCTAssertEqual(element as! String, self.name(forIndex: index))
                        }
                    })
                    
                    it("Then tuple has \(supportedElementsAmount) elements", closure: {
                        let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                        XCTAssertEqual(tupleElements.count, supportedElementsAmount)
                    })
                    
                    it("Then it logs warning to logger", closure: {
                        XCTAssertEqual(mockLogger.loggedMessages(atLevel: .warning).last?.message as? String, """
                            Can currently only create tuples from arrays with up to \(supportedElementsAmount) elements. Elements at index \(unsupportedElementsAmount) and up will be lost
                            """)
                    })
                })
            })
        }
        
        describe("Given an int array") {
            
            var sut: [Int]!
            var tuple: Any!
            
            context("with 1 element", {
                beforeEach {
                    sut = self.intArray(withSize: 1)
                }
                
                context("When tuple is called", closure: {
                    beforeEach {
                        tuple = sut.tuple
                    }
                    
                    it("Then tuple contains correct elements", closure: {
                        XCTAssertEqual(tuple as! (Int), (0))
                    })
                })
            })
            
            (2...supportedElementsAmount).forEach({ (elementCount) in
                context("with \(elementCount) elements", {
                    beforeEach {
                        sut = self.intArray(withSize: elementCount)
                    }
                    
                    context("When tuple is called", closure: {
                        beforeEach {
                            tuple = sut.tuple
                        }
                        
                        it("Then tuple contains correct elements", closure: {
                            let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                            for (index, element) in tupleElements.enumerated() {
                                XCTAssertEqual(element as! Int, index, "expected value \(element) at index \(index) in tuple with size \(elementCount)")
                            }
                        })
                        
                        it("Then tuple has \(elementCount) elements", closure: {
                            let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                            XCTAssertEqual(tupleElements.count, elementCount)
                        })
                    })
                })
            })
            
            context("with unsupported (\(unsupportedElementsAmount)+) amount of elements", {
                var mockLogger: MockLogger!
                
                beforeEach {
                    sut = self.intArray(withSize: unsupportedElementsAmount + 1)
                    mockLogger = MockLogger()
                    logger.relay = mockLogger
                }
                
                context("When tuple is called", closure: {
                    beforeEach {
                        tuple = sut.tuple
                    }
                    
                    it("Then tuple contains correct elements", closure: {
                        let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                        for (index, element) in tupleElements.enumerated() {
                            XCTAssertEqual(element as! Int, index)
                        }
                    })
                    
                    it("Then tuple has \(supportedElementsAmount) elements", closure: {
                        let tupleElements = Mirror(reflecting: tuple!).children.map({ $0.value })
                        XCTAssertEqual(tupleElements.count, supportedElementsAmount)
                    })
                    
                    it("Then it logs warning to logger", closure: {
                        XCTAssertEqual(mockLogger.loggedMessages(atLevel: .warning).last?.message as? String, """
                            Can currently only create tuples from arrays with up to \(supportedElementsAmount) elements. Elements at index \(unsupportedElementsAmount) and up will be lost
                            """)
                    })
                })
            })
        }
        
        describe("Given an array with ints and strings") {
            var sut: [Any]!
            var tuple: Any!
            
            beforeEach {
                sut = [1, 2, "three", "four"]
            }
            
            context("When tuple is called", closure: {
                beforeEach {
                    tuple = sut.tuple
                }
                
                it("Then tuple contains correct elements", closure: {
                    XCTAssert(tuple as! (Int, Int, String, String) == (1, 2, "three", "four"))
                })
            })
        }
    }
}

private extension ArraySpec {
    
    func intArray(withSize size: Int) -> [Int] {
        return (0..<size).map({ Int($0) })
    }
    
    func stringArray(withSize size: Int) -> [String] {
        return intArray(withSize: size).map(name(forIndex:))
    }
    
    func name(forIndex index: Int) -> String {
        return String(describing: index)
    }
}

private func == <T:Equatable> (tuple1:(T,T),tuple2:(T,T)) -> Bool {
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1)
}
