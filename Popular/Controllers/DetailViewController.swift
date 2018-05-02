//
//  DetailViewController.swift
//  Popular
//
//  Created by Zodiac on 2.05.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        getPhoto()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getPhoto() {
        if let url = URL(string: imageUrl) {
            imageView.downloadedFrom(url: url)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
