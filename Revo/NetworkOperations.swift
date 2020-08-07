//
//  Downloader.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/5/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import Foundation

class NetworkOperations {
    func download(songLink: String, completionHandler: @escaping (String) -> ()) {
        if let url = URL(string: songLink) {
            let downloadTask = URLSession.shared.downloadTask(with: url) {
                fileURL, response, error in
                guard let fileURL = fileURL else { return }

                do {
                    let documentsURL = try
                        FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
                    let savedURL = documentsURL.appendingPathComponent("canthelpfallinginlove.m4a")
                    try! FileManager.default.removeItem(at: savedURL)
                    try FileManager.default.copyItem(at: fileURL, to: savedURL)
                    completionHandler(savedURL.absoluteString)
                } catch {
                    print ("file error: \(error)")
                }
            }
            downloadTask.resume()
        }
    }
}
