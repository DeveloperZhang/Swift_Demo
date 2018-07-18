//
//  VZHttpTool.swift
//  VZHttpSwiftTool
//
//  Created by Vicent on 2018/7/17.
//  Copyright © 2018年 VicentZ. All rights reserved.
//

import UIKit


enum VZHttpBodyType {
    case TextPlain
    case Json
}

class VZHttpTool: NSObject,URLSessionDelegate {
    var bodyType: VZHttpBodyType?;
    static let vzHttpTool:VZHttpTool = VZHttpTool();
    class func shareInstance() -> VZHttpTool {
        return vzHttpTool;
    }
    
    class func get(url: String, successBlock:((Any?)->Void)?, failedBlock:((Any?)->Void)?) -> Void {
        self.get(url: url, urlParamDic: [:], successBlock: successBlock, failedBlock: failedBlock);
    }
    
    class func get(url: String, urlParamDic: Dictionary<String, Any>, successBlock:((Any?)->Void)?, failedBlock:((Any?)->Void)?) -> Void {
        var urlResult: String?;
        if !(urlParamDic.isEmpty) {
            let arr = urlParamDic.keys
            let bodyArr = NSMutableArray.init(array: []);
            for key in arr {
                let value = urlParamDic[key];
                bodyArr.add("\(key)=\(value!)");
            }
            let bodyStr: String! = bodyArr.componentsJoined(by: "&")
            let specialStr = url.contains("?") ? "&":"?";
            urlResult = url.appending("\(specialStr)\(bodyStr!)")
        }
        urlResult = urlResult?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        VZHttpTool.shareInstance().bodyType = VZHttpBodyType.TextPlain;
        self.requestWithMethod(method: "GET", url: urlResult!, headerDic: [:], bodyDic: [:], bodyType: VZHttpTool.shareInstance().bodyType!, successBlock: successBlock, failedBlock: failedBlock);
    }
    
    class func requestWithMethod(method: String,
                                 url: String,
                                 headerDic: Dictionary<String, Any>,
                                 bodyDic: Dictionary<String, Any>,
                                 bodyType: VZHttpBodyType,
                                 successBlock:((Any?)->Void)?,
                                 failedBlock:((Any?)->Void)?) -> Void {
        requestWithMethod(method: method, url: url, headerDic: headerDic, bodyDic: bodyDic, bodyType: bodyType, formFile: nil, successBlock: successBlock, failedBlock: failedBlock);
    }
    
    class func requestWithMethod(method: String,
                                 url: String,
                                 headerDic: Dictionary<String, Any>,
                                 bodyDic: Dictionary<String, Any>,
                                 bodyType: VZHttpBodyType,
                                 formFile: Any?,
                                 successBlock:((Any?)->Void)?,
                                 failedBlock:((Any?)->Void)?) -> Void {
        let request: NSMutableURLRequest = NSMutableURLRequest.init(url: URL.init(string: url)!);
        if !method.isEmpty {
            request.httpMethod = method;
        }
        if bodyType == VZHttpBodyType.TextPlain {
            if !bodyDic.isEmpty {
                let arr = bodyDic.keys;
                let bodyArr: NSMutableArray = [NSMutableArray.init(array: [])];
                for key in arr {
                    let value: String = bodyDic[key] as! String;
                    bodyArr.add("\(key)=\(value)");
                }
            }
        } else if bodyType == VZHttpBodyType.Json {
            if !bodyDic.isEmpty {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: bodyDic, options: [])
                } catch {
                    if failedBlock != nil {
                        failedBlock!(error)
                    }
                }
            }
            let hDic: NSMutableDictionary = NSMutableDictionary.init(dictionary: ["Content-Type":"application/json"]);
            hDic.addEntries(from: headerDic)
            request.allHTTPHeaderFields = hDic as? [String : String];
        }
    
        if formFile != nil {
            //TODO 参考OC版本修改即可,略过
        }
        
        
        let session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self.shareInstance(), delegateQueue: OperationQueue.main)
        let dataTask: URLSessionTask = session.dataTask(with: request as URLRequest) {
            data,response,error1 in
            if error1 != nil {
                if (failedBlock != nil) {
                    failedBlock!(error1);
                }
            } else {
                do {
                    let responseObj = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                    if successBlock != nil {
                        successBlock?(responseObj);
                    }
                } catch {
                    let dataStr = String.init(data: data!, encoding: String.Encoding.utf8);
                    if successBlock != nil {
                        var obj: Any;
                        if (dataStr?.isEmpty)! {
                            obj = data as Any;
                        } else {
                            obj = dataStr as Any;
                        }
                        successBlock?(obj);
                    }
                }
            }
        }
        dataTask.resume();
    }
}
