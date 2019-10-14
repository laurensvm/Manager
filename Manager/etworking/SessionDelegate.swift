//
//  SessionDownloadDelegate.swift
//  Manager
//
//  Created by Laurens Van Mieghem on 13/10/2019.
//  Copyright © 2019 Laurens Van Mieghem. All rights reserved.
//

import Foundation

class SessionDelegate: NSObject {
    
    
    
    override init() {
        super.init()
    }
}

extension SessionDelegate: URLSessionDownloadDelegate {
    
    internal func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("TEST")
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten writ: Int64,
                    totalBytesExpectedToWrite exp: Int64) {
        print("downloaded \(100*writ/exp)%")
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        print("Completed")
        
//        print(task.response)
//        if let err = error {
//            print(err)
//        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo fileURL: URL) {
//        print(fileURL)
    }
    
}

extension SessionDelegate: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("wwwwwwwAATTT DE FAK")
    }
}
