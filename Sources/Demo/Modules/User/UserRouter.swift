//
//  UserRouter.swift
//  PerfectREST
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct ADCUsersRouter {
    
    // Members
    static let main = ADCUsersRouter()
    
    // Initializers
    private init() {}
    
    // Methods
    func buildRoutes() -> Routes {
        let usersURI = "/users"
        let userURI = "/users/{user_id}"
        var routes = Routes(baseUri: ADCConstants.URIs.base)
        
        // Create
        routes.add(method: .post, uri: usersURI, handler: ADCUserHandlers.main.create)
        
        // Details
        routes.add(method: .get, uri: userURI, handler: ADCUserHandlers.main.details)
        
        // Update
        routes.add(method: .post, uri: userURI, handler: ADCUserHandlers.main.update)
        
        // Delete
        routes.add(method: .delete, uri: userURI, handler: ADCUserHandlers.main.delete)
        
        // List
        routes.add(method: .get, uri: usersURI, handler: ADCUserHandlers.main.list)
        
        return routes
    }
    
}
