import UserNotifications
import OneSignalFramework

class NotificationService: UNNotificationServiceExtension {
    private var contentHandler: ((UNNotificationContent) -> Void)?
    private var receivedRequest: UNNotificationRequest?
    private var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.receivedRequest = request
        self.contentHandler = contentHandler
        self.bestAttemptContent = request.content.mutableCopy() as? UNMutableNotificationContent

        guard let bestAttemptContent = bestAttemptContent else {
            contentHandler(request.content)
            return
        }

        OneSignal.didReceiveNotificationExtensionRequest(
            request,
            with: bestAttemptContent,
            withContentHandler: contentHandler
        )
    }

    override func serviceExtensionTimeWillExpire() {
        guard let request = receivedRequest,
              let content = bestAttemptContent,
              let contentHandler = contentHandler else { return }

        OneSignal.serviceExtensionTimeWillExpireRequest(
            request,
            with: content
        )
        contentHandler(content)
    }
}
