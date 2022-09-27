//
//  ScanTag.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/09/27.
//

import Foundation

struct ScanTag:Identifiable {
    var id = UUID()
    let content: String
    
    
    init(content:String){
        self.content = content
    }
}
