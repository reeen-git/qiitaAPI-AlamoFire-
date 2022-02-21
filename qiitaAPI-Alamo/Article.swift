//
//  Article.swift
//  qiitaAPI-Alamo
//
//  Created by 高橋蓮 on 2022/02/21.
//

import Foundation
struct Article: Codable {
    var title: String
    var user: User
    struct User: Codable {
        var name: String
    }
}

