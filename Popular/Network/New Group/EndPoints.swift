//
//  EndPoints.swift
//  Popular
//
//  Created by Zodiac on 2.05.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case behance
}

public enum MovieApi {
    case projects
}

extension MovieApi: EndPointType {
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .projects:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["client_id":NetworkManager.APIKey])
        default:
            return .request
        }
    }
    
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .behance: return "https://api.behance.net/v2/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .projects:
            return "projects/64959223/"

        }
    }

}
