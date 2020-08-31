//
//  ViewController.swift
//  dogApi
//
//  Created by COTEMIG on 31/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
   
    @IBOutlet weak var ImageView: UIImageView!
    @IBAction func changeImage(_ sender: Any) {
        requestImage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        requestImage()
    }
    
    private func requestImage() {
        if let url = URL(string: "https://dog.ceo/api/breeds/image/random") {
            let urlSession = URLSession.shared.dataTask(with: url) { (Data, Response, Error) in
                if let data = Data {
                    do {
                        let jsonData = try JSONSerialization
                            .jsonObject(with: data, options: .mutableContainers) as? [String: String]
                        if let image = jsonData {
                            self.downloadImage(imageLink: image["message"] ?? "")
                        }
                    } catch {
                        print("Parse Error")
                    }
                }
            }
            urlSession.resume()
        }
    }

    private func downloadImage(imageLink: String) {
        if let url = URL(string: imageLink) {
            let urlSession = URLSession.shared.dataTask(with: url) { (Data, Response, Error) in
                if let data = Data {
                    DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    self.ImageView.image = image
                    }
                }
            }
            urlSession.resume()
        }
    }
}

