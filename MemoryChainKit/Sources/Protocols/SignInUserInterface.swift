//
//  SignInUserInterface.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/10/13.
//  Copyright © 2019 Memory Chain network technology(China) co,LTD. All rights reserved.
//

import UIKit

public protocol SignInUserInterface {
    //func render(newState:SignInViwwState)
    func configureViewAfterLayout()
    func moveContentForDismissedKeyboard()
    func moveContent(forKeyboardFrame keyboardFrame:CGRect)
}
