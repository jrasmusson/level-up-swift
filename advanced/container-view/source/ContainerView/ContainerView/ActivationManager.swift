//
//  ActivationManager.swift
//  ContainerView
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-09-27.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

enum ActivationError: Error {
    case failure
}

struct ActivationManager {

    static func activateAndPoll(completion: @escaping (Result<Void, Error>) -> Void) {
        // comment in to simulate different functionality
        //        completion(Result.success(()))
        completion(Result.failure(ActivationError.failure))
    }

}

