import XCTest
import Combine
@testable import Pet_ID_iOS

class MockAuthRepository: AuthRepository {
    var authorization = Authorization(accessToken: "expiredToken", refreshToken: "validRefreshToken")
    var isTokenRefreshed = false

    // MARK: - Refresh Token
    func refresh(refreshToken: String) async throws -> Authorization {
        isTokenRefreshed = true
        return Authorization(accessToken: "newAccessToken", refreshToken: "newRefreshToken")
    }

    // MARK: - Retrieve Authorization
    func getAuthorizationFromKeychain() throws -> Authorization {
        return authorization
    }

    func getAuthorizationFromKeychain() -> AnyPublisher<Authorization, UserError> {
        Just(authorization)
            .setFailureType(to: UserError.self)
            .eraseToAnyPublisher()
    }

    // MARK: - Update Token
    func storeAuthorizationToKeychain(auth: Authorization) -> Bool {
        authorization = auth
        return true
    }

    func updateAuthorizationToKeychain(auth: Authorization) -> Bool {
        authorization = auth
        return true
    }

    func deleteAuthorizationFromKeychain() -> Bool {
        return true
    }

    // MARK: - Mock Login and Join (if needed)
    func login(oauth: OAuth, fcmToken: String) async throws -> Authorization {
        return Authorization(accessToken: "loginAccessToken", refreshToken: "loginRefreshToken")
    }

    func join(oauth: OAuth, fcmToken: String, agreedAd: Bool) async throws -> Authorization {
        return Authorization(accessToken: "joinAccessToken", refreshToken: "joinRefreshToken")
    }
}
