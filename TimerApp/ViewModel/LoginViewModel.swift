//
//  LoginViewModel.swift
//  TimerApp
//
//  Created by Florence Fendy on 30/4/2026.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject{
    @Published var userName: String = " "
    @Published var password: String = " "
}
