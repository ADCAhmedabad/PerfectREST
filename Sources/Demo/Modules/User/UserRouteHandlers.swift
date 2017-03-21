//
//  UserRouteHandlers.swift
//  PerfectREST
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct ADCUserHandlers {
    
    static let main = ADCUserHandlers()
    
    private init() {}
    
    /// Handles User Creation request
    func create(request: HTTPRequest, response: HTTPResponse) {
        guard
            let firstname = request.param(name: "firstname"),
            let lastname = request.param(name: "lastname")
            else {
                return response.completed(status: .badRequest)
        }
        
        let user = ADCUser()
        user.firstname = firstname
        user.lastname = lastname
        user.email = request.param(name: "email") ?? ""
        
        do {
            try user.save { id in
                user.id = id as! Int
            }
        } catch {
            print("User creation failure:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        do {
            try response.setBody(json: user.toJSONRepresentable())
        } catch {
            print("User could not be set as JSON in responeBody:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        response.completed(status: .created)
    }
    
    /// Handles User Details request
    func details(request: HTTPRequest, response: HTTPResponse) {
        guard
            let userID = request.urlVariables["user_id"],
            let intUserID = Int(userID)
            else {
                return response.completed(status: .badRequest)
        }
        
        let user = ADCUser()
        user.id = intUserID
        
        do {
            try user.get()
        } catch {
            print("User retrieval failure:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        do {
            try response.setBody(json: user.toJSONRepresentable())
        } catch {
            print("User could not be set as JSON in responeBody:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        response.completed(status: .created)
    }
    
    /// Handles User updation request
    func update(request: HTTPRequest, response: HTTPResponse) {
        guard
            let userID = request.urlVariables["user_id"],
            let intUserID = Int(userID)
            else {
                return response.completed(status: .badRequest)
        }
        
        var data = [(String, Any)]()
        if let firstname = request.param(name: "firstname") {
            data.append(("firstname", firstname))
        }
        
        if let lastname = request.param(name: "lastname") {
            data.append(("lastname", lastname))
        }
        
        if let email = request.param(name: "email") {
            data.append(("email", email))
        }
        
        let user = ADCUser()
        user.id = intUserID
        do {
            try user.update(data: data, idValue: intUserID)
        } catch {
            print("User update failure after updation:\n\(error)")
        }
        
        do {
            try user.get()
        } catch {
            print("User retrieval failure:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        do {
            try response.setBody(json: user.toJSONRepresentable())
        } catch {
            print("User could not be set as JSON in responeBody:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        response.completed(status: .ok)
    }
    
    /// Handles User Deletion request
    func delete(request: HTTPRequest, response: HTTPResponse) {
        guard
            let userID = request.urlVariables["user_id"],
            let intUserID = Int(userID)
            else {
                return response.completed(status: .badRequest)
        }
        
        let user = ADCUser()
        user.id = intUserID
        
        do {
            try user.delete()
        } catch {
            print("User deletion failure:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        response.completed(status: .ok)
    }
    
    /// Handles User Listing request
    func list(request: HTTPRequest, response: HTTPResponse) {
        let user = ADCUser()
        
        do {
            try user.select(whereclause: "", params: [], orderby: [])
        } catch {
            print("Users retrieval failure:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        
        let users = user.row().map { $0.toJSONRepresentable() }
        do {
            try response.setBody(json: ["users" : users])
        } catch {
            print("Users could not be set as JSON in responeBody:\n\(error)")
            return response.completed(status: .internalServerError)
        }
        response.completed(status: .ok)
    }
    
}
