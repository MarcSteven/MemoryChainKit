//
//  Request.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/15.
//  Copyright © 2020 Marc Steven(.com/MarcSteven). All rights reserved.
//

import Foundation
/** Request is a wrapper around the URLRequest that will be sent with URLSession*/

open class Request {
    let urlRequest:URLRequest
    
    let requestConfiguration:HTTPConfiguration
    
    /** Any data received by the request wil be put into the buffer*/
    private var buffer = Data()
    var expectedContentSize:Int?
    private var responseJSONTmp:(Response<Any>)?
    
    private var responseDataTmp:(HTTPURLResponse?,Data,MemoryChainError)?
    
    private var onDownloadProgress:((_ receivedSize:Int,_ expectedSize:Int)->Void)?
    private var onUploadProgress:((_ sentByte:Int64,_ totalByte:Int64)->Void)?
    /** An instance closure that can be define with the matching function*/
    private var onCompleteJSON: ((Response<Any>) -> Void)?

    /**
     An instance closure that can be define with the matching function:
     func response(_ handler:@escaping ((URLResponse?, Data, Error?)->Void))
     */
    private var onCompleteData: ((HTTPURLResponse?, Data, MemoryChainError?) -> Void)?

    /**
     Initializer of Request
     - parameter urlRequest: The actual URLRequest that we want to wrap
     - parameter provider: The provider used to send the request
     */
    init(urlRequest: URLRequest, requestConfiguration: HTTPConfiguration) {
        self.urlRequest = urlRequest
        self.requestConfiguration = requestConfiguration
    }

    /**
     Method that will append data to the current buffer
     - parameter data: the data that needs to be appended
    */
    func append(data: Data) {
        self.buffer.append(data)

        if self.expectedContentSize != nil && self.expectedContentSize! > 0 {
            self.onDownloadProgress?(buffer.count,expectedContentSize!)
        }
    }

    /**
     Method that will update the progress of an upload
     - parameter bytesSent: the total number of bytes already sent
     - parameter bytesToSend: the total number of bytes to send
    */
    func setUploadProgress(bytesSent: Int64, bytesToSend: Int64) {
        self.onUploadProgress?(bytesSent, bytesToSend)
    }

    /**
     Method that needs to be called when the request has completed.
     - parameter response: the URLResponse received if any
     - parameter error: the error received if any
    */
    func onComplete(response: URLResponse?, error: Error?) {
        let httpResponse = response as? HTTPURLResponse
        var error = error
        if httpResponse == nil && error == nil {
            error = (response != nil) ? NetworkError.notHTTPResponse : NetworkError.unknown("Response and Error are nil")
        }

        let validatedError = requestConfiguration.validate(response: httpResponse, data: buffer, error: error)

        if let err = validatedError {
            if requestConfiguration.shouldContinue(with: err) {
                onCompleteJSON?(Response(response: httpResponse, data: buffer, result: .failure(err)))
                onCompleteData?(httpResponse, buffer, validatedError)
            }
            return
        }
        responseDataTmp = ((httpResponse, buffer, validatedError) as! (HTTPURLResponse?, Data, MemoryChainError))
        onCompleteData?(httpResponse, buffer, validatedError)

        var responseToReturn: Response<Any>!
        if let json = try? JSONSerialization.jsonObject(with: buffer as Data, options: JSONSerialization.ReadingOptions.allowFragments) {
            responseToReturn = Response(response: httpResponse, data: buffer, result: .success(json))
        } else if buffer.count == 0 {
            responseToReturn = Response(response: httpResponse, data: buffer, result: .failure(NetworkError.emptyResponse))
        } else {
            responseToReturn = Response(response: httpResponse, data: buffer, result: .failure(NetworkError.jsonDeserialalization))
        }
        
        onCompleteJSON?(responseToReturn)
    }

    /**
     Method that allows you to track the progress of a request.
     - parameter handler: A closure that takes the received size and the expected size as parameters
     - returns: itself
    */
    @discardableResult
    open func uploadProgress(_ handler:@escaping (( _ bytesSent: Int64, _ totalBytes: Int64) -> Void)) -> Self {
        self.onUploadProgress = handler
        return self
    }

    /**
     Method that allows you to track the progress of a request.
     - parameter handler: A closure that takes the received size and the expected size as parameters
     - returns: itself
     */
    @discardableResult
    open func downloadProgress(_ handler:@escaping (( _ receivedSize: Int, _ expectedSize: Int) -> Void)) -> Self {
        self.onDownloadProgress = handler
        return self
    }

    /**
     Method that allows you to track when a request is completed
     - parameter handler: A closure that takes the URLResponse, the Data received (empty if no data), and any error as parameters
     - returns: itself
     */
    @discardableResult
    open func response(_ handler:@escaping ((HTTPURLResponse?, Data, MemoryChainError?) -> Void)) -> Self {
        self.onCompleteData = handler
        if let response = responseDataTmp {
            handler(response.0, response.1, response.2)
        }
        return self
    }

    /**
     Method that allows you to track when a request is completed
     - parameter handler: A closure that takes a Response object as parameters
     - returns: itself
     */
    @discardableResult
    open func responseJSON(_ handler:@escaping ((Response<Any>) -> Void)) -> Self {
        self.onCompleteJSON = handler
        if let response = responseJSONTmp {
            handler(response)
        }
        return self
    }

    /**
     Method that allows you to track when a request is completed
     - parameter handler: A closure that takes a Response object as parameters
     - returns: itself
     */
    @discardableResult
    open func responseObject<T: Decodable>(_ handler:@escaping ((Response<T>) -> Void)) -> Self {
        let newHandler: ((HTTPURLResponse?, Data, MemoryChainError?) -> Void) = { (response, data, error) in
            if let err = error {
                handler(Response(response: response, data: data, result: .failure(err)))
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                handler(Response(response: response, data: data, result: .success(object)))
            } else {
                handler(Response(response: response, data: data, result: .failure(NetworkError.jsonMapping(data))))
            }
        }
        self.onCompleteData = newHandler
        if let response = responseDataTmp {
            newHandler(response.0, response.1, response.2)
        }
        return self
    }
}
