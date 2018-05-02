//
//  EndPoint.swift
//  Popular
//
//  Created by Zodiac on 2.05.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}

