//
//  CollectionViewController.swift
//  Popular
//
//  Created by Zodiac on 2.05.2018.
//  Copyright © 2018 senfonico. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class CollectionViewController: UICollectionViewController, CustomLayoutDelegate {
    
    let networkManager = NetworkManager()
    var modules: [Modules]!
    var urls: [String] = [""]
    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    var selectedIndex = ""
    let images = [#imageLiteral(resourceName: "Placeholder")]
    @IBOutlet weak var retryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationBar()

        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        tableData = []
        cache = NSCache()
        
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self as CustomLayoutDelegate
        }
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        retryBtn.isHidden = true
        getDatas()
        self.urls.removeAll()

    }
    
    @IBAction func retry(_ sender: UIButton) {
        getDatas()
    }

    @objc func getDatas() {
        
        networkManager.getGalleries { (modules, error) in
            if error == nil {
                self.modules = modules
                self.clearNilUrls()
            } else {
                self.setEmptyState()
            }
        }
    }
    
    func setEmptyState() {
        DispatchQueue.main.async {
            self.retryBtn.isHidden = false
        }
    }
    
    func clearNilUrls() {
        
        for module in modules {
            if module.src != "" {
                self.urls.append(module.src!)
            }
        }
        reloadCells()
    }
    
    func reloadCells() {
         DispatchQueue.main.async {
            self.retryBtn.isHidden = true
            self.collectionView?.reloadData()
            self.refreshCtrl?.endRefreshing()
        }
    }
    
    func prepareNavigationBar() {
        let imageView = UIImageView(image:UIImage(named: "NavigationImage"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        let firstColor = UIColor(red: 157, green: 255, blue: 255, alpha: 1.0)
        let secondColor = UIColor(red: 255, green: 200, blue: 255, alpha: 1.0)
        navigationController?.navigationBar.addGradient(colors: [firstColor, secondColor])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return urls.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell

        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.borderWidth = 5.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:2.0,height: 2.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 10.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){

            print("Cached image used, no need to download it")
            cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        } else{
            
            let artworkUrl = urls[indexPath.row]
            let url:URL! = URL(string: artworkUrl)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        let img:UIImage! = UIImage(data: data)
                        cell.imageView.image = img
                        self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                    })
                }
            })
            task.resume()
        }
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = urls[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController
        {
            let vc = segue.destination as? DetailViewController
            vc?.imageUrl = selectedIndex
        }
    }

}
