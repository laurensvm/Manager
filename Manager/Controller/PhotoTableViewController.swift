//
//  PhotoTableViewController.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 22/07/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import UIKit

class PhotoTableViewController: UIViewController {
    let baseurl = "http://127.0.0.1:5000/filesystem/image/anach/ana_cheri_bed_2.0.jpg/"
    let username = "theexission@gmail.com"
    let password = "passwd01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage(from: self.baseurl)
        print("Works")
        self.view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    func downloadImage(from urlString: String) {
        let username = "theexission@gmail.com"
        let password = "passwd01"
        let loginData = "\(username):\(password)".data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        
        // create the request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }

}
