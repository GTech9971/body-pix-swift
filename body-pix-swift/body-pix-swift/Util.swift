//
//  Util.swift
//  body-pix-swift
//
//  Created by George Dambara on 2024/08/10.
//

import Foundation

typealias InputSize = (inputHeight: Int, inputWidth: Int);

private let internalResolutionPercentages: [BodyPixInternalResolution: Double] = [
    .low: 0.25,
    .medium: 0.5,
    .high: 0.75,
    .full: 1.0
]

private func ToInternalResolutionPercentage(internalResolution:BodyPixInternalResolution)-> Double!{
    return internalResolutionPercentages[internalResolution];
}


private func IsValidInputResolution(resolution:Double, oputputStride:BodyPixOutputStride)->Bool{
    return Int((resolution - 1.0)) % oputputStride.rawValue == 0;
}

private func ToValidInputResolution(inputResolution:Double, outputStride:BodyPixOutputStride) -> Int{
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


func PadTo(size:InputSize, target: (targetH:Int, targetW:Int))-> Padding{
    
    let width:Double = Double(size.inputWidth);
    let height:Double = Double(size.inputHeight);
    
    let targetAspect: Double = Double(target.targetW) / Double(target.targetH);
    let aspect:Double = width / height;
    
    var padT:Double = 0;
    var padB:Double  = 0;
    var padL:Double = 0;
    var padR:Double = 0;
    
    if(aspect < targetAspect){
        padT = 0;
        padB = 0;
        padL = (0.5 * (targetAspect * height - width)).rounded();
        padR = (0.5 * (targetAspect * height - width)).rounded();
    }else{
        padT = (0.5 * ((1.0 / targetAspect) * width - height)).rounded();
        padB = (0.5 * ((1.0 / targetAspect) * width - height)).rounded();
        padL = 0;
        padR = 0;
    }
    
    return Padding(Top: Int(padT), Botton: Int(padB), Left: Int(padL), Right: Int(padR));
}
