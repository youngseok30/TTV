//
//  IntroduceData.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

enum IntroduceData: Int {
    
    case I = 1
    case II = 2
    case III = 3
        
    var title: String {
        switch self {
        case .I:
            return "Type the text you want to\nmake a video of"
        case .II:
            return "Automatic video mach, sound, subtitle generation"
        case .III:
            return "Download videos and upload them on SNS"
            
        }
    }
    
    var description: String {
        switch self {
        case .I:
            return "TTV A.I allows you to produce images using only text.Image clips are created based on paragraphs (line changes)"
        case .II:
            return "Do you want to make the video richer? Change the image and add sound through simple editing."
        case .III:
            return "Download autocomplete videos or upload them to various platforms through SNS upload function."
        }
    }
    
    var image: UIImage? {
        return UIImage.init(named: "introduce_0\(self.rawValue)")
    }
    
}
