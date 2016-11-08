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
    
    
    
    static func detectPitch(frequencyValue:Float) -> (noteName:String,octave:Int,noteFrequency:Float){
        var frequency = frequencyValue
        while (frequency > Float(noteFrequencies[noteFrequencies.count-1])) {
            frequency = frequency / 2.0
        }
        while (frequency < Float(noteFrequencies[0])) {
            frequency = frequency * 2.0
        }
        
        var minDistance: Float = 10000.0
        var index = 0
        
        for i in 0..<noteFrequencies.count {//vai verificando de nota por nota até achar a que tem a menor distancia
            let distance = fabsf(Float(noteFrequencies[i]) - frequency)
            if (distance < minDistance){
                index = i
                minDistance = distance
            }
        }
        
        let octave = Int(log2f(frequencyValue / frequency))
        return ("\(noteNames[index])",octave,Float(noteFrequencies[index])*(powf(2.0,Float(octave))))
    }
    
    static func noteDiference(firstFrequency:Float,secondFrequency:Float)->(frequencyDiference:Float,octaveDiference:Int){
        
        let frequencyA = self.detectPitch(frequencyValue: firstFrequency)
        let frequencyB = self.detectPitch(frequencyValue: secondFrequency)
        
        return (frequencyA.noteFrequency-frequencyB.noteFrequency,frequencyA.octave-frequencyB.octave)
    }
    
    static func getFrequencyFor(noteSymbol:String,octave:String) -> Float{
        
        for i in 0..<noteNames.count {
            if noteSymbol == noteNames[i] {
                return Float(noteFrequencies[i]) * powf(2,Float(octave)!)
            }
        }
        return 0.0
    }
}
