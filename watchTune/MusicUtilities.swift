//
//  MusicUtilities.swift
//  watchTune
//
//  Created by Vitor Muniz on 07/11/16.
//  Copyright © 2016 Vitor Muniz. All rights reserved.
//

import Foundation

struct MusicUtilities {
    static let noteFrequencies = [16.35,17.32,18.35,19.45,20.6,21.83,23.12,24.5,25.96,27.5,29.14,30.87]//oitava 0
    static let noteNames = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    
    static func detectPitch(frequencyValue:Double) -> (noteName:String,octave:Int,noteFrequency:Double){
        var frequency = frequencyValue
        while (frequency > noteFrequencies[noteFrequencies.count-1]) {
            frequency = frequency / 2.0
        }
        while (frequency < noteFrequencies[0]) {
            frequency = frequency * 2.0
        }
        
        var minDistance: Double = 10000.00
        var index = 0
        
        for i in 0..<noteFrequencies.count {//vai verificando de nota por nota até achar a que tem a menor distancia
            let distance = abs(noteFrequencies[i] - frequency)
            if (distance < minDistance){
                index = i
                minDistance = distance
            }
        }
        
        let octave = Int(log2(frequencyValue / frequency))
        return ("\(noteNames[index])",octave,noteFrequencies[index]*(pow(2.0,Double(octave))))
    }
    
    static func noteDiference(firstFrequency:Double,secondFrequency:Double)->(frequencyDiference:Double,octaveDiference:Int){
        
        let frequencyA = self.detectPitch(frequencyValue: firstFrequency)
        let frequencyB = self.detectPitch(frequencyValue: secondFrequency)
        
        return (frequencyA.noteFrequency-frequencyB.noteFrequency,frequencyA.octave-frequencyB.octave)
    }
    
    static func frequencyFor(noteSymbol:String,octave:String) -> Double{
        
        for i in 0..<noteNames.count {
            if noteSymbol == noteNames[i] {
                return noteFrequencies[i] * pow(2.0,Double(octave)!)
            }
        }
        return 0.0
    }
    
    static func directionToTune(desireNote:String,currentFrequency:Double)->Double{
        var desireNote = detectPitch(frequencyValue:frequencyFor(noteSymbol: desireNote, octave: "4"))
        let currentNote = detectPitch(frequencyValue: currentFrequency)
        var directionToTune = 0.0
        var percentage = 0.0
        var beforeOctave = 0.0
        var afterOctave = 0.0
        var currentOctave = 0.0
        if desireNote.noteName != currentNote.noteName{
            //dizer qual a afinacao
            if desireNote.octave != currentNote.octave {
                desireNote = detectPitch(frequencyValue: frequencyFor(noteSymbol: desireNote.noteName, octave: "\(currentNote.octave)"))
            }
            if currentNote.octave > 0 {
                beforeOctave = frequencyFor(noteSymbol: desireNote.noteName, octave: (currentNote.octave-1).description)
                afterOctave = frequencyFor(noteSymbol: desireNote.noteName, octave: (currentNote.octave+1).description)
                currentOctave = frequencyFor(noteSymbol: desireNote.noteName, octave: currentNote.octave.description)
                
                let distanceOctaveBefore = abs(beforeOctave - currentNote.noteFrequency)
                let distanceOctaveAfter = abs(afterOctave - currentNote.noteFrequency)
                let distanceOctaveCurrent = abs(currentOctave - currentNote.noteFrequency)
                
                var minDistance = 0.0
                
                minDistance = Double(min(distanceOctaveBefore,distanceOctaveAfter))
                minDistance = Double(min(minDistance,Double(distanceOctaveCurrent)))
                
                if distanceOctaveAfter == minDistance {
                    directionToTune = afterOctave - currentNote.noteFrequency
                }else if distanceOctaveBefore == minDistance {
                    directionToTune = beforeOctave - currentNote.noteFrequency
                }else {
                    directionToTune = currentOctave - currentNote.noteFrequency
                }
                
            }else {
                afterOctave = frequencyFor(noteSymbol: desireNote.noteName, octave: (currentNote.octave+1).description)
                currentOctave = frequencyFor(noteSymbol: desireNote.noteName, octave: currentNote.octave.description)
                
                let distanceOctaveAfter = abs(afterOctave - currentNote.noteFrequency)
                let distanceOctaveCurrent = abs(currentOctave - currentNote.noteFrequency)
                
                var minDistance = 0.0
                
                minDistance = min(distanceOctaveAfter,distanceOctaveCurrent)
                
                if distanceOctaveAfter == minDistance {
                    directionToTune = afterOctave - currentNote.noteFrequency
                }else {
                    directionToTune = currentOctave - currentNote.noteFrequency
                }
            }
            if directionToTune < 0.0 {
                percentage = directionToTune/(currentOctave - beforeOctave)
            }else {
                percentage = directionToTune/(afterOctave - currentOctave)
            }
        }
        
        return percentage
    }
    
}
