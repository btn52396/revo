//
//  Downloader.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import Foundation

class Downloader {
    func load(songLink: String, completionHandler: @escaping (String) -> ()) {
        let url = URL(string: songLink)!

        let downloadTask = URLSession.shared.downloadTask(with: url) {
            urlOrNil, responseOrNil, errorOrNil in
            guard let fileURL = urlOrNil else { return }
            
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                completionHandler(savedURL.absoluteString)
            } catch {
                print ("file error: \(error)")
            }
        }
        downloadTask.resume()
    }
}
