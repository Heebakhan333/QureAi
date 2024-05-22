//
//  OTPViewController.swift
//  QureAi
//
//  Created by Heeba Khan on 22/05/24.
//

import UIKit
import Alamofire

class OTPViewController: UIViewController {
    
    
    var otpBoxes: [UITextField] = []
    let headers: HTTPHeaders = [
        //  "Authorization": "Bearer 644e806c-bf4d-4093-a22d-6d46a501965d",
        "Content-Type": "application/json"
    ]
    var phoneNumber: String = ""
    
    //MARK: Outlets
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var authenticationText: UILabel!
    @IBOutlet weak var otpStackView: UIStackView!
    @IBOutlet weak var verificationCodeText: UILabel!
    @IBOutlet weak var enterOtpText: UILabel!
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!
    @IBOutlet weak var otpTextField5: UITextField!
    @IBOutlet weak var otpTextField6: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var verifyOtpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func verifyOtpActionButton(_ sender: UIButton) {
        let otp = otpBoxes.map { $0.text ?? "" }.joined()
        print("Entered OTP: \(otp)")
        
        // Perform action when the button is tapped (e.g., verify OTP)
        verifyOTP(otp: otp, phoneNumber: self.phoneNumber)
    }
    
    @IBAction func backActionButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private functions
    
    
    private func setUpUI(){
        setUpBackgroundGradient()
        setUpOtpTextFields()
        // Disable the button initially
        self.verifyOtpButton.isEnabled = false
        self.authenticationText.text = AppStrings.authentication
        self.enterOtpText.text = AppStrings.enterOtpText
        self.verificationCodeText.text = AppStrings.verificationCode
        self.verifyOtpButton.setTitle(AppStrings.verifyOtp, for: .normal)
        self.verifyOtpButton.setTitleColor(AppColors.gray5, for: .disabled)
        self.verifyOtpButton.addShadow()
    }
    
    private func setUpOtpTextFields(){
        otpBoxes = [otpTextField1, otpTextField2, otpTextField3, otpTextField4, otpTextField5, otpTextField6]
        for box in otpBoxes {
            customizeTextField(box)
            box.delegate = self
            box.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
        self.otpTextField1.textAlignment = .center
        
    }
    private func setUpBackgroundGradient(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let colorTop = (isDarkMode ? AppColors.gradientColor1Dark : AppColors.gradientColor1Light)
        let colorBottom = (isDarkMode ? AppColors.gradientColor2Dark : AppColors.gradientColor2Light)
        self.backgroundView.addGradientLayer(colors: [colorTop, colorBottom],
                                             startPoint: CGPoint(x: 0, y: 0),
                                             endPoint: CGPoint(x: 1, y: 1))
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let currentIndex = otpBoxes.firstIndex(of: textField) else { return }
        let nextIndex = currentIndex + 1
        
        // Move to the next box if the current box is filled
        if textField.text?.count == 1 {
            if nextIndex < otpBoxes.count {
                otpBoxes[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                verifyOtpButton.setTitle(AppStrings.verifyOtp, for: .normal)
                verifyOtpButton.backgroundColor = AppColors.accentColor
                verifyOtpButton.setTitleColor(AppColors.getStartedBtnColor, for: .normal)
                for box in otpBoxes {
                    activateOtpBoxes(box)
                }
                verifyOtpButton.isEnabled = otpBoxes.allSatisfy { $0.text?.count == 1 }
                if otpBoxes.allSatisfy({ $0.text?.count == 1 }) {
                    verifyOtpButton.isEnabled = true
                    // Call the API since all boxes are filled
                    let otp = otpBoxes.map { $0.text ?? "" }.joined()
                    verifyOTP(otp: otp, phoneNumber: self.phoneNumber)
                }
            }
        }
        
        // Enable the button if all boxes are filled
        
    }
    //    @objc func textFieldDidChange(_ textField: UITextField) {
    //        // Automatically focus on the next box when the current box is filled
    //        guard let currentIndex = otpBoxes.firstIndex(of: textField) else { return }
    //        let nextIndex = currentIndex + 1
    //        if nextIndex < otpBoxes.count {
    //            otpBoxes[nextIndex].becomeFirstResponder()
    //        } else {
    //            // If the last box is filled, enable the button
    //            verifyOtpButton.setTitle(AppStrings.verifyOtp, for: .normal)
    //            verifyOtpButton.backgroundColor = AppColors.accentColor
    //            verifyOtpButton.setTitleColor(AppColors.gray1, for: .normal)
    //
    //            verifyOtpButton.isEnabled = otpBoxes.allSatisfy { $0.text?.count == 1 }
    //        }
    //    }
    
    private func customizeTextField(_ textField: UITextField) {
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.textColor = AppColors.onboardingText
        textField.applyCustomStyle()
        textField.clipsToBounds = false
        textField.backgroundColor = UIColor(white: 1.0, alpha: 0.5) // Light tint
    }
    
    private func activateOtpBoxes(_ textField: UITextField) {
        textField.applyCustomStyle(borderColor: AppColors.accentColor)
    }
}

extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only digits and limit the length to 1 character per box
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) && (textField.text?.count ?? 0) + string.count - range.length <= 1
    }
}

extension OTPViewController {
    
    func verifyOTP(otp: String, phoneNumber: String) {
        let parameters: [String: Any] = ["otp": otp, "phone_number": phoneNumber]
        let url = "https://platformapi.qure.ai/accounts/auth/phone_number/?next=/profile/" // Replace with your API URL
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .response { response in
            if let statusCode = response.response?.statusCode {
                print("Response status code: \(statusCode)")
                
                if let errorCode = ErrorCode(rawValue: statusCode) {
                    // Handle error code using the ErrorCode enum
                    switch errorCode {
                    case .otpSuccess:
                        self.showErrorAlert()
                        print("OTP success verified")
                        // Trigger success
                    default:
                        // For other error codes, print the corresponding error message
                        print(errorCode.errorMessage) // Trigger failure
                    }
                } else {
                    // Handle unrecognized error codes
                    print("Unrecognized error code: \(statusCode)")
                    // Trigger failure
                }
            } else {
                print("Invalid response")
                // Trigger failure
            }
        }
    }
    
    private func showErrorAlert() {
           let alert = UIAlertController(title: "Success", message: "Go To Worklist", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
}

