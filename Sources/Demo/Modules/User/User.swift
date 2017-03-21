//
//  User.swift
//  PerfectREST
//

import PerfectLib
import StORM
import PostgresStORM


class ADCUser: PostgresStORM {
    
    // MARK: Properties
    var id = 0
    var firstname = ""
    var lastname = ""
    var email = ""
    
    
    // MARK: Methods
    /// Defines Tablename that needs to be mapped with this model
    override open func table() -> String {
        return "adc_users"
    }
    
    /// Fills info from database into this method using ORM
    override func to(_ this: StORMRow) {
        id = this.data["id"] as? Int ?? 0
        firstname = this.data["firstname"] as? String ?? ""
        lastname = this.data["lastname"] as? String ?? ""
        email = this.data["email"] as? String ?? ""
    }
    
    /// Iterates over database rows and map those rows into array of this model
    func row() -> [ADCUser] {
        return results.rows
            .map {
                let user = ADCUser()
                user.to($0)
                return user
        }
    }
    
    /// Converts this model into json
    func toJSONRepresentable() -> [String : Any] {
        return [
            "id" : id,
            "firstname" : firstname,
            "lastname" : lastname,
            "email" : email
        ]
    }
    
}
