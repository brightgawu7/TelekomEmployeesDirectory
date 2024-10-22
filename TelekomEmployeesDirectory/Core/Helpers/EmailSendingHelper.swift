import UIKit

enum EmailSendingHelper {
    static func sendEmail(to emailAddress: String?) {
        guard let emailAddress = emailAddress, !emailAddress.isEmpty else {
            return
        }

        guard let emailURL = URL(string: "mailto:\(emailAddress)"),
              UIApplication.shared.canOpenURL(emailURL)
        else {
            return
        }

        UIApplication.shared.open(emailURL)
    }
}
