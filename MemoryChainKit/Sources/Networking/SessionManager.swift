//
//  SessionManager.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation

/** SessionManager delegate , conform to URLSessionDataDelegate*/

public protocol SessionManagerDelegate:URLSessionDataDelegate {
    /**
        dictionary that allows to get a request based on the task generated when the request is sent
     */
    var requests: [URLSessionTask: Request] { get set}
}
class SessionManager: NSObject, SessionManagerDelegate {

    static let `default` = SessionManager()

    var requests = [URLSessionTask: Request]()

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let request = requests[task] else {return}
        request.setUploadProgress(bytesSent: totalBytesSent, bytesToSend: totalBytesExpectedToSend)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let request = requests[dataTask] else {return}
        request.append(data: data)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let request = requests[dataTask] else {return}
        request.expectedContentSize = Int(response.expectedContentLength)
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let request = requests.removeValue(forKey: task) else {return}
        request.onComplete(response: task.response, error: error)
    }
}
