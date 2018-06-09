//
//  ImageViewController.swift
//  HeyDude
//
//  Created by Sean McCalgan on 2018/06/08.
//  Copyright © 2018 Sean McCalgan. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imgurArray = ["https://i.imgur.com/w4cG7Ik.jpg", "https://i.imgur.com/3oNa8.jpg", "https://i.imgur.com/S6H8YXB.jpg", "https://i.imgur.com/kOtY3Js.jpg"]
        let randomItem = Int(arc4random() % UInt32(imgurArray.count))
        let urlToLoad = imgurArray[randomItem]
        
        if let url = URL(string: urlToLoad) {
            imageView.contentMode = .scaleAspectFit
            downloadImage(url: url)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: (viewBackground.frame.midX - 23), y: (viewBackground.frame.midY - 23), width: 46, height: 46)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        viewBackground.addSubview(activityIndicator)
    
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                
                activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: data)
            }
        }
    }

}
