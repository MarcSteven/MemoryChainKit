//
//  UIImageExtension.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2020/3/9.
//  Copyright © 2020 Marc Zhao(https://github.com/MarcSteven). All rights reserved.
//

import UIKit
public extension UIImageView {
    
    func load(url:URL) {
        let serialQueue = DispatchQueue(label: "serial")
        serialQueue.async {
            [weak self] in
            guard let stringSelf = self else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) {
                (data,response,error)in
                if let data = data {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            stringSelf.image = image
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
