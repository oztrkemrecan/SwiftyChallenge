//
//  Extensions.swift
//  Popular
//
//  Created by Zodiac on 30.04.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func addGradient( colors : [UIColor]) {
        
        var frame: CGRect = self.bounds
        frame.size.height += 20
        
        setBackgroundImage(UINavigationBar.gradient(size: frame.size, colors: colors), for: .default)
    }
    
    private static func gradient(size : CGSize, colors : [UIColor]) -> UIImage? {
        
        let cgcolors = colors.map { $0.cgColor }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        defer { UIGraphicsEndImageContext() }
        
        var locations : [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
}

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
