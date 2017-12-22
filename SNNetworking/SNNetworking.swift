//
//  SNNetworking.swift
//  VTravel
//
//  Created by Jason Lee on 03/11/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation
import AFNetworking

protocol SNNetworkingApi {
    var method: SN.Networking.HttpMethod { get set }
    var url: String { get set }
    var parameters: StandardDictionary? { get set }
    var files: [SN.Networking.UploadingFile]? { get set }
    var functionName: String { get set }
    var responseSuccess: SN.Networking.networkingDidSuccess? { get set }
    
    init()
}
extension SNNetworkingApi {
    static var apiName: String { return String(describing: Self.self) }
    var apiName: String { return String(describing: self) }
}

extension SN {
    class Networking {
        static let `default` = SN.Networking()
        
        fileprivate lazy var sessionManager: AFHTTPSessionManager = { return AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default) }()
        
        fileprivate init() { sessionManager.requestSerializer = AFJSONRequestSerializer() }
    }
}
extension SN.Networking {
    @discardableResult
    func request(_ request: Request) -> SN.Networking {
        willRequest(request)
        
        sessionManager.responseSerializer.acceptableContentTypes = request.acceptableContentTypesSet
        
        switch request.api.method {
        case .get:
            sessionManager.get(request.api.url, parameters: request.api.parameters, progress: request.progressing, success: { dataTask, object in
                self.onSuccess(request, object)
            }) { dataTask, error in
                self.onFailure(request, error)
            }
        case .post:
            sessionManager.post(request.api.url, parameters: request.api.parameters, progress: request.progressing, success: { dataTask, object in
                self.onSuccess(request, object)
            }) { dataTask, error in
                self.onFailure(request, error)
            }
        case .upload:
            sessionManager.post(request.api.url, parameters: request.api.parameters, constructingBodyWith: { formData in
                guard let files = request.api.files else { return } 
                for file in files {
                    formData.appendPart(withFileData: file.fileData, name: file.parameterName, fileName: file.fileName, mimeType: file.mimeType.suffix)
                }
            }, progress: request.progressing, success: { dataTask, object in 
                self.onSuccess(request, object)
            }) { dataTask, error in
                self.onFailure(request, error)
            }
        }
        
        return self
    }
}
extension SN.Networking {
    func willRequest(_ request: Request) {
        guard request.isAllowedDebugRequest else { return }
        SN.log("\(request)")
    }
    func didRequest(_ response: Response) {
        guard response.request.isAllowedDebugResponse else { return }
        SN.log("\(response)")
    }
}
extension SN.Networking {
    func onSuccess(_ request: Request, _ object: Any?) {
        var response = Response(request: request)
        
        if let result = request.api.responseSuccess?(object, response) {
            response = result
        } else if let result = request.responseTranfer?(object, response) {
            response = result
        } else {
            if let dictObject = object as? [String : Any] {
                response.data = dictObject
            } else if let arrayObject = object as? [Any] {
                response.data = ["list" : arrayObject]
            } else if let anyObject = object {
                response.data = ["data" : anyObject]
            }
        }
        
        didRequest(response)
        handleFinishing(response)
    }
    func onFailure(_ request: Request, _ error: Error?) {
        let code = (error as NSError?)?.code ?? -1
        let response = Response.failure(request, code, message: error?.localizedDescription ?? "No Error Message")
        
        didRequest(response)
        handleFinishing(response)
    }
}
extension SN.Networking {
    func handleFinishing(_ response: Response) {
        guard response.request.isCanceled.negative else { 
            let currentDate = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss").string(from: Date())
            SN.log("[REQUEST CANCELED] ********** \(currentDate)\n" + "[API]\n\(response.request.api.apiName)\n")
            return
        }
        response.request.finished?(response)
    }
}
extension SN.Networking {
    enum HttpMethod { case post, get, upload }
    enum AcceptableContentTypes: String {
        case text_plain = "text/plain"
        case text_html = "text/html"
        case text_json = "text/json"
        case application_json = "application/json"
    }
    enum MimeType: String {
        case jpeg = "image/jpeg"
        case png = "image/png"
        case bmp = "image/bmp"
        
        var suffix: String {
            switch self {
            case .jpeg: return ".jpg"
            case .png: return ".png"
            case .bmp: return ".bmp"
            }
        }
    }
}
extension SN.Networking {
    struct UploadingFile {
        var fileData: Data
        var parameterName: String
        var fileName: String
        var mimeType: MimeType
    }
}
extension SN.Networking {
    class Request {
        var api: SNNetworkingApi
        
        fileprivate(set) var progressing: SN.Networking.networkingProgressing? = nil
        fileprivate(set) var finished: SN.Networking.networkingDidFinish? = nil
        fileprivate(set) var responseTranfer: SN.Networking.networkingDidSuccess? = nil
        
        fileprivate var acceptableContentTypes: [AcceptableContentTypes]? = [.text_plain, .text_html, .text_json, .application_json]
        fileprivate var acceptableContentTypesSet: Set<String> {
            guard let acceptableContentTypes = acceptableContentTypes else { return Set() }
            var tempSet = Set<String>()
            let _ = acceptableContentTypes.map { tempSet.insert($0.rawValue) }
            return tempSet
        }
        
        var isCanceled: Bool = false
        var isAllowedDebugRequest: Bool = true
        var isAllowedDebugResponse: Bool = true
        var isAllowedDebugResponseResult: Bool = true
        
        init(api: SNNetworkingApi) { self.api = api }
    }
}
extension SN.Networking.Request {
    @discardableResult
    func onProgressing(_ closure: SN.Networking.networkingProgressing?) -> Self {
        progressing = closure
        return self
    }
    @discardableResult
    func onFinished(_ closure: SN.Networking.networkingDidFinish?) -> Self {
        finished = closure
        SN.Networking.default.request(self)
        return self
    }
    @discardableResult
    func onResponsed(_ closure: SN.Networking.networkingDidSuccess?) -> Self {
        responseTranfer = closure
        return self
    }
}
extension SN.Networking.Request: CustomStringConvertible {
    var description: String {
        let parametersString = "\(api.parameters != nil ? "\(api.parameters!)" : "No parameters")\n"
        let currentDate = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss").string(from: Date())
        var returningString = "[NETWORK REQUEST] \n********** \(currentDate) **********\n" +
            "[API]\n\(api.functionName)\n" + 
            "[URL]\n\(api.url)\n" + 
        "[PARAMETERS]\n\(parametersString)\n"
        
        if let files = self.api.files {
            returningString.append("[FILES]\n\(files.count > 0 ? "" : "No Files")")
            for file in files {
                returningString.append("<File name=\"\(file.parameterName)\" length=\"\(file.fileData.count)\">\(file.fileName)\(file.mimeType.suffix)</File>")
            }
            returningString.append("\n")
        }
        return returningString
    }
}

extension SN.Networking {
    class Response {
        var request: Request
        var code: Int = -1
        var message: String? = nil
        var data: StandardDictionary? = nil
        
        init(request: Request) { self.request = request }
    }
}
extension SN.Networking.Response {
    static func success(_ request: SN.Networking.Request, _ code: Int) -> SN.Networking.Response {
        let response = SN.Networking.Response(request: request)
        response.code = code
        return response
    }
    static func failure(_ request: SN.Networking.Request, _ code: Int, message: String? = nil) -> SN.Networking.Response {
        let response = SN.Networking.Response(request: request)
        response.code = code
        response.message = message
        return response
    }
}
extension SN.Networking.Response: CustomStringConvertible {
    var description: String {
        let parametersString = "\(request.api.parameters != nil ? "\(request.api.parameters!)" : "No parameters")\n"
        let dataString = request.isAllowedDebugResponseResult ? "\(data != nil ? "\(data!)" : "No data")\n" : "Hidden data"
        let currentDate = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss").string(from: Date())
        var returningString = "[NETWORK RESPONSE] \n********** \(currentDate) **********\n" +
            "[API]\n\(request.api.functionName)\n" +
            "[URL]\n\(request.api.url)\n" +
        "[PARAMETERS]\n\(parametersString)"
        
        if let files = request.api.files {
            returningString.append("[FILES]\n\(files.count > 0 ? "" : "No Files")")
            for file in files {
                returningString.append("<File name=\"\(file.parameterName)\" length=\"\(file.fileData.count)\">\(file.fileName)\(file.mimeType.suffix)</File>")
            }
            returningString.append("\n")
        }
        
        returningString += "[CODE]\n\(code)\n" +
            "[MESSAGE]\n\(message ?? "No message")\n" +
        "[DATA]\n\(dataString)\n"
        return returningString
    }
}

extension SN.Networking {
    typealias networkingProgressing = (Progress) -> Void
    typealias networkingDidFinish = (SN.Networking.Response) -> Void
    typealias networkingDidSuccess = (Any?, SN.Networking.Response) -> SN.Networking.Response
}
