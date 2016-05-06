//
//  Network.swift
//  Ben
//
//  Created by Benjamin Herzog on 10.03.16.
//  Copyright © 2016 Benjamin Herzog. All rights reserved.
//

import Foundation
import Mapper
import Helper

// MARK: - Endpoint

public protocol UrlParameterType {
	var urlParameter: [String: String]? { get }
}

public extension UrlParameterType {
	var urlParameter: [String: String]? { return nil }
}

public protocol HeaderType {
	var header: [String: String]? { get }
}

public extension HeaderType {
	var header: [String: String]? { return nil }
}

public protocol Endpoint: UrlParameterType, HeaderType {
	associatedtype ObjectType: Mappable
	
	var path: String { get }
}

public extension Endpoint {
	
	func request(completion: ((response: Response<ObjectType>) -> Void)?) -> Request<ObjectType>
	{
		return Request(path: path, urlParameter: urlParameter, header: header, completion: completion)
	}
}

// MARK: - Response

public struct Response<ObjectType: Mappable> {
	
	public var successful = false
	public var statusCode = 0
	public var object: ObjectType?
	public var objects: [ObjectType]?
	public var error: NSError?
	public var json: AnyObject?
	public var data: NSData?
	public var request: Request<ObjectType>
	
	internal init(data: NSData?, response: NSHTTPURLResponse?, error: NSError?, request: Request<ObjectType>) {
		
		self.request = request
		
		guard let data = data else {
			return
		}
		
		self.data = data
		
		guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) else {
			return
		}
		
		self.json = json
		
		statusCode = response?.statusCode ?? 0
		
		successful = error == nil && statusCode == 200
		self.error = error
		
		(object, objects) = Mapper.map(json)
	}
}

// MARK: - Request

public struct Request<T: Mappable> {
	
	public var path: String
	public var urlParameter: [String: String]?
	public var header: [String: String]?
	public var completion: ((response: Response<T>) -> Void)?
}

// MARK: - NSOperation Wrapper

public class RequestOperation<T: Mappable>: NSOperation {
	
	var urlRequest: NSURLRequest
	
	var request: Request<T>
	
	private var _finished = false
	private var _executing = false
	
	override public var executing: Bool {
		get { return _executing }
		set {
			willChangeValueForKey("isExecuting")
			_executing = newValue
			didChangeValueForKey("isExecuting")
		}
	}
	
	override public var finished: Bool {
		get { return _finished }
		set {
			willChangeValueForKey("isFinished")
			_finished = newValue
			didChangeValueForKey("isFinished")
		}
	}
	
	init?(baseUrl: String, request: Request<T>) {
		
		self.urlRequest = NSURLRequest()
		
		self.request = request
		
		super.init()
		
		var urlString = "\(baseUrl)\(request.path)"
		
		if let urlParameter = request.urlParameter {
			let parameterAsString = urlParameter.urlParameterRepresentation
			urlString = "\(urlString)?\(parameterAsString)"
		}
		
		guard let url = NSURL(string: urlString) else {
			print("no valid url: \(urlString)")
			return nil
		}
		
		let r = NSMutableURLRequest(URL: url)
		
		request.header?.forEach {
			r.setValue($0.1, forHTTPHeaderField: $0.1)
		}
		
		self.urlRequest = r
	}
	
	override public func start() {
		executing = true
		NSURLSession.sharedSession().dataTaskWithRequest(self.urlRequest) {
			[weak self] data, response, error in
			
			guard let weakSelf = self else { return }
			
			let response = Response(data: data, response: response as? NSHTTPURLResponse, error: error, request: weakSelf.request)
			
			weakSelf.request.completion?(response: response)
			
			weakSelf.executing = false
			weakSelf.finished = true
			}.resume()
	}
}

public class RequestPool: NSOperationQueue {
	
	public internal(set) var baseURL: String
	
	public init(baseURL: String) {
		self.baseURL = baseURL
	}
	
	public func addRequest<T: Mappable>(request: Request<T>) {
		guard let op = RequestOperation(baseUrl: baseURL, request: request) else {
			print("Could not create an operation....")
			return
		}
		addOperation(op)
	}
}
