//
//  Util.swift
//  body-pix-swift
//
//  Created by George Dambara on 2024/08/10.
//

import Foundation

typealias InputSize = (inputHeight: Int, inputWidth: Int);

let internalResolutionPercentages: [BodyPixInternalResolution: Double] = [
    .low: 0.25,
    .medium: 0.5,
    .high: 0.75,
    .full: 1.0
]

func ToInternalResolutionPercentage(internalResolution:BodyPixInternalResolution)-> Double!{
    return internalResolutionPercentages[internalResolution];
}


func IsValidInputResolution(resolution:Double, oputputStride:BodyPixOutputStride)->Bool{
    return Int((resolution - 1.0)) % oputputStride.rawValue == 0;
}

func ToValidInputResolution(inputResolution:Double, outputStride:BodyPixOutputStride) -> Int{
    if(IsValidInputResolution(resolution: inputResolution, oputputStride: outputStride)){
        return Int(inputResolution);
    }
    return Int((Int(inputResolution) / outputStride.rawValue) * outputStride.rawValue + 1);
}

func ToInputResolutionHeightAndWidth(internalResolution:BodyPixInternalResolution,
                                     outputStride:BodyPixOutputStride,
                                     size : InputSize) ->(Int, Int){
    
    let internalResolutionPercentage:Double = ToInternalResolutionPercentage(internalResolution: internalResolution);
    
    let height:Double = Double(size.inputHeight) * internalResolutionPercentage;
    let width:Double = Double(size.inputWidth) * internalResolutionPercentage;
    
    return (ToValidInputResolution(inputResolution: height, outputStride: outputStride),
        ToValidInputResolution(inputResolution: width, outputStride: outputStride)
    )
}
