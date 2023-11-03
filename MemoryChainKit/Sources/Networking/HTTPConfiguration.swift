//
//  HTTPConfiguration.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/4/17.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//

import Foundation

/**
 HTTP Provider is the protocol that defines an API and the relationship you want to have with it.
 You can define many providers in your app if you have different API (yours and external for instance)
 */
public protocol HTTPConfiguration {

    /**
     The base URL of your API, the link that is common to every request
     */
    var baseURL: URL { get }

    /**
     The delegate used by NSURLSession, can be overriden to manage unsupported cases
     */
    var delegate: SessionManagerDelegate { get }

    /**
     The session used by the provider. A default session is provided, but this can be overriden for custom configurations
     */
    var session: URLSession { get }

    /**
     Defaults Headers, those headers can be provided when implementing the protocol. They will be added to each request
     */
    var additionalHeaders: [String: String] { get }

    /**
     Addional Parameters, those parameters can be provided when implementing the protocol. They will be added to each request
     */
    var additionalParams: [String: Any] { get }

    /**
     Validation function, it is called when a request is received.
     You can implement a custom validation if you want to define when we should consider the result a failure
     - parameter response: the HTTPURLResponse returned by NSURLSession
     - paramater data: the data that was returned in the response's body
     - parameter error: any error returned by NSURLSession
     - returns: any Error that you would like to pass to consider the result a failure
     */
    func validate(response: HTTPURLResponse?, data: Data, error: Error?) -> MemoryChainError?

    /**
     A function called if an error is found before a request returns a failure response.
     It can be used for instance if the error is a HTTP 401 error and that you don't want to proceed
     - parameter error: the error that the request currently holds
     - returns: a boolean that tells us whether or not we should send a result back
     */
    func shouldContinue(with error: MemoryChainError) -> Bool

    /**
     A function that allows you to define the default encoding for an HTTPMethod.
     By default this will return json for .post but you can implement that function to return .form instead
     - parameter method: the HTTPMethod for which you need to define the encoding
     - returns: The proper encoding
     */
    func defaultEncoding(for method: HTTPMethod) -> ParameterEncoding
}

/**
 This HTTP Provider extension gives a default implementation for the basic behavior of a request.
 */
public extension HTTPConfiguration {

    /**
     The default delegate uses the default instance of SessionManager
     */
    var delegate: SessionManagerDelegate { return SessionManager.default }

    /**
     The default session will occur on the main queue and with its configuration. A default delegate is implemented.
    */
    var session: URLSession {
       return URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
    }

    /**
     Default headers should be left empty
     */
    var additionalHeaders: [String: String] { return [String: String]() }

    /**
     Default params should be left empty
    */
    var additionalParams: [String: Any] { return [String: Any]() }

    /**
     Default validation.
     Will return an Error if the HTTP status code is greater than 399 (400+: client errors, 500+: server errors)
     */
    func validate(response: HTTPURLResponse?, data: Data, error: Error?) -> MemoryChainError? {
        if let error = error {
            return NetworkError.error(with: error)
        } else if let response = response {
            return response.statusCode > 399 ? NetworkError.error(with: response.statusCode) : nil
        } else {
            return NetworkError.unknown("Response and error are nil")
        }
    }

    /**
     Default implementation of shouldContinue
     Will always return true. It is up to you whether or not you want to stop the request
     */
    func shouldContinue(with error: MemoryChainError) -> Bool {
        return true
    }

    /**
     Function that provides the default encoding for every HTTP method
     */
    func defaultEncoding(for method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get, .connect, .head, .options, .patch, .delete, .trace :
            return .url
        case .post, .put :
            return .json
        }
    }

    /**
     This is the method that needs to be called from a provider to send the request.
     - parameter route: the route object that defines the request
     - returns: the request being sent
     */
     func request(_ route: Route) -> Request {

        let path = route.path != "" ? baseURL.appendingPathComponent(route.path) : baseURL

        var request = URLRequest(url: path)

        let allParams = additionalParams + route.params
        do {
            if let form = route.multipartForm {
                try request.encode(form: form)
            } else {
               try request.encode(parameters: allParams, encoding: route.encoding ?? self.defaultEncoding(for: route.method))
            }
        } catch (let error) {
            let NikkaError = error as? MemoryChainError
            let r = Request(urlRequest: request, requestConfiguration: self)
            r.onComplete(response: nil, error: NikkaError ?? NetworkError.parameterEncoding(allParams))
            return r
        }

        request.httpMethod = route.method.rawValue

        let headers = additionalHeaders + route.headers
        headers.forEach({
            request.setValue($1, forHTTPHeaderField: $0)
        })

        let r = Request(urlRequest: request, requestConfiguration: self)

        let task = session.dataTask(with: request)
        delegate.requests[task] = r
        task.resume()

        return r
    }
}

/**
 This default provider should be used when you want to send a request with a full given URL.
 No behavior is defined, you'll need to defined everything manually.
 */
public class DefaultProvider: HTTPConfiguration {
    public var baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    /**
     Static function that allows you to send a request with an empty provider.
     - parameter route: Route object that defines method, parameters, etc.
                        The full URL should be specified in the path of the Route
    */
    public static func request(_ route: Route) -> Request {
        let newRoute = Route(path: "", method: route.method, params: route.params, headers: route.headers, encoding: route.encoding)
        if let url = URL(string: route.path) {
            let emptyProvider = DefaultProvider(baseURL: url)
            return emptyProvider.request(newRoute)
        } else {
            let defaultURL = URL(string: "https://google.com")!
            let r = Request(urlRequest: URLRequest(url: defaultURL), requestConfiguration: DefaultProvider(baseURL: defaultURL))
            r.onComplete(response: nil, error: NetworkError.invalidURL(route.path))
            return r
        }
    }
}

/**
 Convenience method that allows us to merge dictionaries
 */
func +<K, V>(left: [K: V], right: [K: V]?) -> [K: V] {
    var dict = left
    right?.forEach({ dict[$0] = $1 })
    return dict
}
