//
//  LoginViewModel.swift
//  BangJon
//
//  Created by ZISACHMAD on 16/05/21.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var countryCode = ""
    @Published var phNumber = ""
    @Published var showAlert = false
    @Published var errorMsg = ""
    @Published var ID = ""
    @Published var isLoading = false
    
    // KIRIM OTP VERFIVIKASI NOMOR HP USER
    func verifyUser() {
        withAnimation{isLoading = true}
        
        // UNDO INI JIKA TEST PAKAI HP DAN NOMOR BENERAN
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        //
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+\(countryCode + phNumber)", uiDelegate: nil) { ID, err in
            if let error = err {
                self.errorMsg = error.localizedDescription
                self.showAlert.toggle()
                return
            }
            self.ID = ID!
            self.alertWithTF()
        }
    }
    
    // ALERT UNTUK KODE OTP
    func alertWithTF() {
        let alert = UIAlertController(title: "Verification", message: "Enter OTP Code", preferredStyle: .alert)
        
        alert.addTextField { txt in
            txt.placeholder = "123456"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            if let code = alert.textFields?[0].text {
                self.LoginUser(code: code)
            }
            else {
                self.reportError()
            }
        }))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    // BERHASIL LOGIN
    func LoginUser(code: String) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: code)
        Auth.auth().signIn(with: credential) { result, err in
            if let error = err {
                self.errorMsg = error.localizedDescription
                self.showAlert.toggle()
                return
            }
            print("success")
        }
    }
    
    // JIKA ADA KESALAHAN
    func reportError() {
        self.errorMsg = "Please coba lagi jon"
        self.showAlert.toggle()
    }
}

