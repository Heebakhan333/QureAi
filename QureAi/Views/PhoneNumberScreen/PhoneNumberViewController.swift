//
//  PhoneNumberViewController.swift
//  QureAi
//
//  Created by Heeba Khan on 21/05/24.
//

import Alamofire
import UIKit

class PhoneNumberViewController: UIViewController {
    
    var viewModel: PhoneNumberViewModel?
    var navigator: Navigator?
    var themeManager: ThemeManager = AppThemeManager()
    
    //MARK: Outlets
    @IBOutlet weak var signInText: UILabel!
    
    @IBOutlet weak var phoneNumberBackgroundView: UIView!
    @IBOutlet weak var welcomeBackText: UILabel!
    
    @IBOutlet weak var phoneNumberMessageText: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var enterPhoneNumberText: UILabel!
    @IBOutlet weak var errorStackVie: UIStackView!
    @IBOutlet weak var sendOtpButton: UIButton!
    @IBOutlet weak var errorStackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpPhoneNumberTextField()
        moveToOtpScreenIfSuccess()
        themeManager.currentTheme = DarkTheme()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    
    @IBAction func sendOtpActionBtn(_ sender: UIButton) {
        submitPhoneNumber()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setUpUI(){
        viewModel = PhoneNumberViewModel()
        self.setUpBackgroundGradient()
        self.signInText.text = AppStrings.signIn
        self.signInText.textColor = AppColors.gray5
        self.signInText.font = UIFont.customFont(.bold, size: 30)
        self.backButton.tintColor = AppColors.backButtonTint
        self.backButton.backgroundColor = AppColors.gray5
        self.enterPhoneNumberText.textColor = AppColors.gray5
        self.welcomeBackText.textColor = AppColors.gray5
        self.sendOtpButton.tintColor = AppColors.gray1
        self.sendOtpButton.setTitleColor(AppColors.gray1, for: .normal)
        self.sendOtpButton.backgroundColor = AppColors.gray5
        self.sendOtpButton.addShadow()
        self.errorStackHeight.constant = 0
        self.sendOtpButton.setTitle(AppStrings.sendOtp, for: .disabled)
        self.sendOtpButton.isEnabled = false
    }
    
    private func setUpPhoneNumberTextField(){
        self.phoneNumberTextField.delegate = self
        self.phoneNumberTextField.textColor = AppColors.gray5
        self.phoneNumberTextField.placeholder = AppStrings.mobileNumber
        self.phoneNumberTextField.textColor = AppColors.gray9
        self.phoneNumberTextField.isUserInteractionEnabled = true
        self.phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        // self.phoneNumberTextField.font = UIFont.customFont(.medium, size: (16.0/UIScreen.main.scale))
        self.phoneNumberTextField.textAlignment = .left
        self.phoneNumberTextField.borderStyle = .roundedRect
        self.phoneNumberTextField.backgroundColor = .clear
        //self.phoneNumberTextField.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 0.7) // Set background color with tint
        let prefixLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        prefixLabel.text = "+91"
        prefixLabel.textAlignment = .center
        prefixLabel.textColor = AppColors.gray5
        self.phoneNumberTextField.leftView = prefixLabel
        self.phoneNumberTextField.leftViewMode = .always
        self.phoneNumberTextField.applyCustomStyle(borderColor: AppColors.base5)
    }
    
    private func setUpBackgroundGradient(){
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let colorTop = (isDarkMode ? AppColors.gradientColor1Dark : AppColors.gradientColor1Light)
        let colorBottom = (isDarkMode ? AppColors.gradientColor2Dark : AppColors.gradientColor2Light)
        self.phoneNumberBackgroundView.addGradientLayer(colors: [colorTop, colorBottom],
                                                        startPoint: CGPoint(x: 0, y: 0),
                                                        endPoint: CGPoint(x: 1, y: 1))
        
    }
    
    // Handle the API response in the completion handler
    private func moveToOtpScreenIfSuccess() {
        // Set ViewModel completion handler
        viewModel?.apiCompletion = { success, error in
            if success {
                self.navigateToOtpScreen()
                // Navigate to the OTP screen if success
                print("go to otp")
            } else {
                // Handle error
                if let error = error {
                    // Handle the error if it's not nil
                    if let errorCode = error as? ErrorCode {
                        // If the error is of type ErrorCode, handle it using ErrorCode enum
                        self.handleErrorCode(errorCode)
                    } else {
                        // Handle other types of errors
                        print("Unknown error: \(error.localizedDescription)")
                    }
                } else {
                    // Handle case where error is nil
                    print("Unknown error: Error is nil")
                }
            }
        }
    }
    
    func handleErrorCode(_ code: ErrorCode) {
        // Display error message on screen
        print("Error: \(code.rawValue) - \(code.errorMessage)")
        self.enterPhoneNumberText.text = "Error: \(code.rawValue) - \(code.errorMessage)"
        self.errorStackHeight.constant = 10
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // Update the gradient background when the interface style changes
            setUpBackgroundGradient()
        }
    }
    
    func submitPhoneNumber() {
        // Define the headers
        guard let phoneNumber = self.phoneNumberTextField.text else {
            // Show error message to user
            return
        }
        let param = "+91" + (self.phoneNumberTextField.text ?? "")
        viewModel?.sendPhoneNumberToAPI(param)
        
    }
    
    func navigateToOtpScreen() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: OTPViewController.self)) as? OTPViewController
        let param = "+91" + (self.phoneNumberTextField.text ?? "")
        vc?.phoneNumber = param
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


//Extension for UItextField methods

extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow only digits and limit the length to 10 characters
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        // Calculate the new length after the replacement
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count == 10 {
            // Hide the keyboard after 10 digits
            textField.resignFirstResponder()
            sendOtpButton.isEnabled = true
            sendOtpButton.backgroundColor = AppColors.accentColor
            phoneNumberTextField.textColor = AppColors.accentColor
            phoneNumberTextField.applyCustomStyle(borderColor: AppColors.themeColor)
            textField.text = newText // Update the text field with the new text
            return false
        }
        if newText.count > 10 {
            textField.text = String(newText.prefix(10))
            return false // Return false to prevent further editing
        }
        
        
        return allowedCharacters.isSuperset(of: characterSet) && newText.count <= 10
    }
    
}

//func apiCall() {
//
//
//    // Define the headers
//    let headers: HTTPHeaders = [
//        // "Authorization": "Bearer 644e806c-bf4d-4093-a22d-6d46a501965d",
//        "Content-Type": "application/json"
//    ]
//
//    // Define the parameters
//    let parameters: [String: Any] = ["phone_number": "+918077088706"]
//
//    // Perform the request
//    AF.request("https://platformapi.qure.ai/accounts/phone_number/otp/send/",
//               method: .post,
//               parameters: parameters,
//               encoding: JSONEncoding.default,
//               headers: headers)
//    .response { response in
//        if let statusCode = response.response?.statusCode {
//            print("Response status code: \(statusCode)")
//        } else {
//            print("Invalid response")
//        }
//    }
//
//
//}
