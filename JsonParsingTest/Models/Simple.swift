//
//  Simple.swift
//  JsonParsingTest
//
//  Created by YOUNGSIC KIM on 2019-12-20.
//  Copyright © 2019 YOUNGSIC KIM. All rights reserved.
//

import Foundation

struct Simple: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var thumbnail: String
    var email: String
}

let simpleDataList = [
    Simple(name: "user name", thumbnail: "https://randomuser.me/api/portraits/thumb/women/82.jpg", email: "email")
]
