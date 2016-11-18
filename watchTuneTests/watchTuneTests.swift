//
//  watchTuneTests.swift
//  watchTuneTests
//
//  Created by Vitor Muniz on 18/11/16.
//  Copyright © 2016 David Sanford. All rights reserved.
//

import XCTest
@testable import watchTune
class MusicUtilitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDetectCorrectPitch(){
        let tupla = (noteName:"A",octave:4,noteFrequency:440.0)
        XCTAssertTrue(MusicUtilities.detectPitch(frequencyValue: 440.0) == tupla)
        XCTAssertTrue(MusicUtilities.detectPitch(frequencyValue: 442.0) == tupla)
        XCTAssertFalse(MusicUtilities.detectPitch(frequencyValue: 500) == tupla)
    }
    
    func testDirectionToTune(){
        XCTAssertLessThan(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 550),1)
        XCTAssertGreaterThan(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 330.0),-1)
        XCTAssertEqual(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 440.0),0)
    }
    
    
}
