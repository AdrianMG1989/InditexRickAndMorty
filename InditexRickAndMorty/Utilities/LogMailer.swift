//
//  LogMailer.swift
//  InditexRickAndMorty
//
//  Created by Adrian Molinier Gomez on 1/9/25.
//

import UIKit
import SwiftUI
import MessageUI

enum LogMailer {
    
    static func sendLogs(to recipients: [String],
                         subject: String = "Logs de la app",
                         body: String = "Adjunto los logs generados por la aplicación.",
                         logFileURL: URL) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("El dispositivo no está configurado para enviar correos")
            
            let activityVC = UIActivityViewController(
                activityItems: [logFileURL],
                applicationActivities: nil
            )
            
            if let topVC = UIApplication.shared.topViewController() {
                topVC.present(activityVC, animated: true)
            }
            return
        }
        
        let mailVC = MFMailComposeViewController()
        mailVC.setToRecipients(recipients)
        mailVC.setSubject(subject)
        mailVC.setMessageBody(body, isHTML: false)
        
        if let logData = try? Data(contentsOf: logFileURL) {
            mailVC.addAttachmentData(logData,
                                     mimeType: "text/plain",
                                     fileName: "app_logs.txt")
        }
        
        // Presentamos el mail desde el top view controller
        if let topVC = UIApplication.shared.topViewController() {
            mailVC.mailComposeDelegate = topVC as? MFMailComposeViewControllerDelegate
            topVC.present(mailVC, animated: true)
        }
    }
}

private extension UIApplication {
    func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return tab.selectedViewController.flatMap { topViewController(base: $0) }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
