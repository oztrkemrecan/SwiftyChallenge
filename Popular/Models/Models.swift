//
//  Models.swift
//  Popular
//
//  Created by Zodiac on 2.05.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import Foundation

struct ProjectApiResponse {
    let http_code: Int
    let project: Project
}

extension ProjectApiResponse: Decodable {
    
    private enum ProjectsApiResponseCodingKeys: String, CodingKey {
        case http_code = "http_code"
        case project = "project"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProjectsApiResponseCodingKeys.self)
        
        http_code = try container.decode(Int.self, forKey: .http_code)
        project = try container.decode(Project.self, forKey: .project)
        
    }
}


struct Project {
    
    let modules: [Modules]
}

extension Project: Decodable {
    
    enum ProjectCodingKeys: String, CodingKey {
        case modules
    }
    
    
    init(from decoder: Decoder) throws {
        let modulesContainer = try decoder.container(keyedBy: ProjectCodingKeys.self)
        
        modules = try modulesContainer.decode([Modules].self, forKey: .modules)
    }
}

struct Modules {
    let src: String?
}

extension Modules: Decodable {
    
    enum ModulesCodingKeys: String, CodingKey {
        case src = "src"
    }
    
    
    init(from decoder: Decoder) throws {
        let modulesContainer = try decoder.container(keyedBy: ModulesCodingKeys.self)
        
        do {
            src = try modulesContainer.decode(String.self, forKey: .src)
        } catch {
            src = ""
        }
        
    }
}
