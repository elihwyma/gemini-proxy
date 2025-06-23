import Vapor

func routes(_ app: Application) throws {

    app.get("v1", "**") { req async throws -> Response in
        // Extract the path components after "v1/"
        let pathComponents = req.url.path.dropFirst(3).split(separator: "/")
        
        // Ensure we have at least one component
        guard !pathComponents.isEmpty else {
            throw Abort(.badRequest, reason: "Invalid request path")
        }
        
        // Join the components to form the new path
        let newPath = pathComponents.joined(separator: "/")
        
        let newURI = URI(string: "https://generativelanguage.googleapis.com/v1beta/openai/\(newPath)")
        var headers = HTTPHeaders()
        headers.replaceOrAdd(name: "Content-Type", value: "application/json; charset=UTF-8")
        headers.replaceOrAdd(name: "Authorization", value: req.headers["Authorization"].first ?? "")
        
        let ret = try await req.client.get(newURI, headers: headers)
        return try await ret.encodeResponse(for: req)
    }
    
    app.post("v1", "**") { req async throws -> Response in
        // Extract the path components after "v1/"
        let pathComponents = req.url.path.dropFirst(3).split(separator: "/")
        
        // Ensure we have at least one component
        guard !pathComponents.isEmpty else {
            throw Abort(.badRequest, reason: "Invalid request path")
        }
        
        // Join the components to form the new path
        let newPath = pathComponents.joined(separator: "/")
        
        var headers = HTTPHeaders()
        headers.replaceOrAdd(name: "Content-Type", value: "application/json; charset=UTF-8")
        headers.replaceOrAdd(name: "Authorization", value: req.headers["Authorization"].first ?? "")
        
        let newURI = URI(string: "https://generativelanguage.googleapis.com/v1beta/openai/\(newPath)")
        // Forward the request to the new URL
        let ret = try await req.client.post(newURI, headers: headers, content: req.body.string ?? "")
        return try await ret.encodeResponse(for: req)
    }
    
}
