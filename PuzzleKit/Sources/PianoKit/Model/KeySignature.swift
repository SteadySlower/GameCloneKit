//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import Foundation

enum KeySignature {
    case sharp, flat
    
    var sign: String {
        switch self {
        case .sharp:
            return "♯"
        case .flat:
            return "♭"
        }
    }
}
