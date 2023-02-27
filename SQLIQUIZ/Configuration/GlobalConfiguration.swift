//
//  GlobalConfiguration.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

private var configSharedInstance: GlobalConfiguration!

enum HTTPMethod {
    case get
    case post
    case patch
    case delete
}

class GlobalConfiguration {

    static var baseUrl = "https://reqres.in/api/"

    var webServices = [String: Any]()

    // MARK: - Setup

    class func setup() {
        configSharedInstance = GlobalConfiguration()
        configSharedInstance.initWebServices()
    }

    class var sharedInstance: GlobalConfiguration! {
        if configSharedInstance == nil {
            print("error: shared called before setup")
        }
        return configSharedInstance
    }

    // MARK: - Webservice

    func initWebServices() {
        // Get all the Users
        addWebService(name: .wsGetAllUsers, url: "users?page=%@", method: .get, demo: "getAllUsers")
       
    }

    func addWebService(name: String, baseUrl: String = baseUrl, url: String, method: HTTPMethod, demo: String = "") {
        var dic: [String: Any] = [:]

        dic[.wsUrl] = baseUrl + url
        dic[.wsMethod] = method
        dic[.wsDemo] = demo

        configSharedInstance.webServices[name] = dic
    }
}

