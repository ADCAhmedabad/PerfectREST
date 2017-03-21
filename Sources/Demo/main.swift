import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PostgresStORM

// Configure: PostgresConnector
PostgresConnector.host		= "localhost"
PostgresConnector.username	= "adc_admin"
PostgresConnector.password	= "admin1234"
PostgresConnector.database	= "perfect_adc"
PostgresConnector.port		= 5432

// Setup: Users Table
let user = ADCUser()
try? user.setup()

// Configure: Server
let server = HTTPServer()
server.serverPort = 8181

// Register: Routes
server.addRoutes(ADCUsersRouter.main.buildRoutes())

// Run: Server
do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
