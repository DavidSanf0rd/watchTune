//
//  musicUtilitiesQuickTest.swift
//  watchTune
//
//  Created by Vitor Muniz on 18/11/16.
//  Copyright © 2016 David Sanford. All rights reserved.
//

import Nimble
import Quick
@testable import watchTune
class MusicUtilitiesSpec: QuickSpec {
    override func spec(){
        it("should get the correct pitch") {
            let tupla = (noteName:"A",octave:4,noteFrequency:440.0)
            expect(MusicUtilities.detectPitch(frequencyValue: 442) == tupla).to(beTrue())
        }
        context("getting the direction to tune"){
            describe("octaves greather than 0"){
                it("aproximate to the pich from the left to the right"){
                    print(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 330))
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 330) > -1).to(beTrue())
                }
                
                it("aproximate to the pich from the right to the left"){
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 550) < 1).to(beTrue())
                }
                
                it("get the correct pich"){
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 440) == 0).to(beTrue())
                }
            }
            describe("when octave is 0") {
                it("aproximate to the pich from the left to the right"){
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 16.35) > -1).to(beTrue())
                }
                it("aproximate to the pich from the right to the left"){
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 30.87) < 1).to(beTrue())
                }
                it("get the correct pich"){
                    expect(MusicUtilities.directionToTune(desireNote: "A", currentFrequency: 27.5) == 0).to(beTrue())
                }
            }
        }
    }
}

